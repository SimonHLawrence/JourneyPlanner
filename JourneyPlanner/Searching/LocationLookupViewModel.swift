//
//  LocationLookupViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI
import Combine

class LocationViewModel: ObservableObject {
    
  @Published var title: String
  @Published var locationText: String
  @Published var resolvedLocations: [Location] = []
  @Binding var selectedLocation: Location?
  
  var locationLookupService: LocationLookupService
  var bag: Set<AnyCancellable> = []
  
  init(title: String, locationLookupService: LocationLookupService, selectedLocation: Binding<Location?>) {
    self.title = title
    self.locationText = selectedLocation.wrappedValue?.name ?? ""
    self.locationLookupService = locationLookupService
    self._selectedLocation = selectedLocation
    
    bag.insert(
      $locationText
        .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .removeDuplicates()
        .sink { [weak self] value in
          
          self?.performSearch(location: value)
        })
  }
  
  func performSearch(location: String) {
    
    Task {
      
      let results = try await locationLookupService.performSearch(location: location)
      
      await MainActor.run {
        
        self.resolvedLocations = results
      }
    }
  }
}
