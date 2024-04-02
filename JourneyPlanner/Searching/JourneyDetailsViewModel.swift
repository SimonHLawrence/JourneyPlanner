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
  
  @Published var startLocationTitle: String = "Starting From"
  @Published var startLocation: LocationViewModel.Location?
  @Published var viaLocationTitle: String = "Via"
  @Published var viaLocation: LocationViewModel.Location?
  @Published var destinationTitle: String = "Destination"
  @Published var destination: LocationViewModel.Location?
  @Published var leavingAt: Date = Date.now
  @Published var results: [Journey] = []
  
  init(journeyService: JourneyService) {
    self.journeyService = journeyService
  }
  
  func submit() async throws {
    
    guard
      let fromCoordinate = startLocation?.result.placemark.coordinate,
      let toCoordinate = destination?.result.placemark.coordinate
    else {
      return
    }
    let viaCoordinate = viaLocation?.result.placemark.coordinate
    
    let results = try await journeyService.getJourneys(from: fromCoordinate, to: toCoordinate, via: viaCoordinate, leavingAt: leavingAt)
    
    await MainActor.run {
    
      self.results = results
    }
  }
}
