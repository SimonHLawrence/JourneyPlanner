//
//  JourneyDetailsViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI
import CoreLocation

class JourneyDetailsViewModel: ObservableObject {
  
  private var journeyService: JourneyService
  var locationLookupService: LocationLookupService
  
  @Published var startLocationTitle: String = "Starting From"
  @Published var startLocation: Location?
  @Published var viaLocationTitle: String = "Via"
  @Published var viaLocation: Location?
  @Published var destinationTitle: String = "Destination"
  @Published var destination: Location?
  @Published var leavingAt: Date = Date.now
  @Published var results: [Journey] = []
  @Published var error: String?
  
  init(journeyService: JourneyService, locationLookupService: LocationLookupService) {
    self.journeyService = journeyService
    self.locationLookupService = locationLookupService
  }
  
  func submit() async throws -> Bool {
    
    guard
      let fromCoordinate = startLocation?.coordinate,
      let toCoordinate = destination?.coordinate
    else {
      return false
    }
    let viaCoordinate = viaLocation?.coordinate
    
    do {
      let results = try await journeyService.getJourneys(from: fromCoordinate, to: toCoordinate, via: viaCoordinate, leavingAt: leavingAt)
      
      await MainActor.run {
        
        self.results = results
      }
      return true
    } catch {
      
      await MainActor.run {
        
        self.error = error.localizedDescription
      }
      return false
    }
  }
}
