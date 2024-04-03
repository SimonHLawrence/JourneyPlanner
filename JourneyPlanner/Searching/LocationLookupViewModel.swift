//
//  LocationLookupViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI
import Combine

class LocationViewModel: ObservableObject {
    
  enum State {
    case empty
    case noResults
    case ready
  }
  
  @Published var title: String
  @Published var locationText: String
  @Published var resolvedLocations: [Location] = []
  @Published var state: State = .empty
  @Binding var selectedLocation: Location?
  
  var locationLookupService: LocationLookupService
  var bag: Set<AnyCancellable> = []
  
  var emptyTitle: String {
    "Enter an address to find locations."
  }
  
  var noResultsTitle: String {
    "No matching addresses."
  }
  
  var prompt: String {
    "Enter a London address..."
  }
  
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
    
    guard !location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      self.state = .empty
      self.resolvedLocations = []
      return
    }
    
    Task {
      
      do {
        let results = try await locationLookupService.performSearch(location: location)
        
        await MainActor.run {
          
          self.state = (results.isEmpty) ? .noResults : .ready
          self.resolvedLocations = results
        }
      } catch {
        await MainActor.run {
          
          self.state = .noResults
          self.resolvedLocations = []
        }
      }
    }
  }
}
