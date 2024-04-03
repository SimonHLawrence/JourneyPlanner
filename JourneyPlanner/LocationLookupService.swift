//
//  LocationLookupService.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 03/04/2024.
//

import Foundation
import MapKit
import Contacts

extension MKCoordinateRegion {
  
  static var london: MKCoordinateRegion {
    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                       span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
  }
}

struct Location: Identifiable {
  var id = UUID()
  var name: String?
  var coordinate: CLLocationCoordinate2D
  let postalAddress: String
  
  init(id: UUID = UUID(), result: MKMapItem) {
    self.id = id
    self.name = result.name
    self.coordinate = result.placemark.coordinate
    if let postalAddress = result.placemark.postalAddress {
      let formatter = CNPostalAddressFormatter()
      self.postalAddress = formatter.string(from: postalAddress)
    } else {
      self.postalAddress = "-"
    }
    print(self)
  }
  
  init(id: UUID = UUID(), name: String?, coordinate: CLLocationCoordinate2D, postalAddress: String) {
    self.id = id
    self.name = name
    self.coordinate = coordinate
    self.postalAddress = postalAddress
  }
}

protocol LocationLookupService {
  
  func performSearch(location: String) async throws -> [Location]
}

struct MockLocationLookupService: LocationLookupService {
  
  static var mockLocations: [String: Location] = [
    "Clink St": Location(name: "Clink St",
                         coordinate: CLLocationCoordinate2D(latitude: 51.50709251574277,
                                                            longitude: -0.09174991369779009),
                         postalAddress: "Clink St\nLondon\nEngland\nSE1\nUnited Kingdom"),
    "Barbican Centre": Location(name: "Barbican Centre",
                                coordinate: CLLocationCoordinate2D(latitude: 51.5216946,
                                                                   longitude: -0.0940015),
                                postalAddress: "Silk St\nLondon\nEngland\nEC2Y 8DS\nUnited Kingdom"),
    "Millennium Bridge": Location(name: "Millennium Bridge",
                                  coordinate: CLLocationCoordinate2D(latitude: 51.509597,
                                                                     longitude: -0.098534),
                                  postalAddress: "London\nEngland\nUnited Kingdom")
  ]
  
  func performSearch(location: String) async throws -> [Location] {
    
    if let location = MockLocationLookupService.mockLocations[location] {
      return [location]
    }
    
    return []
  }
}

struct MapKitLocationLookupService: LocationLookupService {
  
  func performSearch(location: String) async throws -> [Location] {
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = location
    request.region = MKCoordinateRegion.london
    
    let localSearch = MKLocalSearch(request: request)
    let result = try await localSearch.start()
    
    return result.mapItems.map { Location(result: $0) }
  }
}
