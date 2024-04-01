//
//  LocationLookupViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI
import MapKit
import Combine
import Contacts

extension MKCoordinateRegion {
  
  static var london: MKCoordinateRegion {
    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                       span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
  }
}

class LocationViewModel: ObservableObject {
  
  struct Location: Identifiable {
    var id = UUID()
    var result: MKMapItem
    let postalAddress: String
    
    init(id: UUID = UUID(), result: MKMapItem) {
      self.id = id
      self.result = result
      if let postalAddress = result.placemark.postalAddress {
        let formatter = CNPostalAddressFormatter()
        self.postalAddress = formatter.string(from: postalAddress)
      } else {
        self.postalAddress = "-"
      }
    }
  }
  
  @Published var title: String
  @Published var locationText: String
  @Published var resolvedLocations: [Location] = []
  @Binding var selectedLocation: Location?
  
  var bag: Set<AnyCancellable> = []
  
  init(title: String, selectedLocation: Binding<Location?>) {
    self.title = title
    self.locationText = selectedLocation.wrappedValue?.result.name ?? ""
    self._selectedLocation = selectedLocation
    
    bag.insert(
      $locationText
        .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
        .removeDuplicates()
        .sink { [weak self] value in
          
          self?.performSearch(location: value)
        })
  }
  
  func performSearch(location: String) {
    
    if location.isEmpty {
      DispatchQueue.main.async { [weak self] in
        self?.resolvedLocations = []
      }
    }
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = self.locationText
    request.region = MKCoordinateRegion.london
    
    let localSearch = MKLocalSearch(request: request)
    localSearch.start { (response, error) in
      guard let response = response else {
        // TODO: Handle the error.
        if let error {
          print(error)
        }
        return
      }
      
      DispatchQueue.main.async { [weak self] in
        self?.resolvedLocations = response.mapItems.map { Location(result: $0) }
      }
    }
  }
}
