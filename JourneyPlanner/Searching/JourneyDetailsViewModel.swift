//
//  JourneyDetailsViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI
import CoreLocation
import TFLJourney
import OpenAPIRuntime
import OpenAPIURLSession

extension CLLocationCoordinate2D {
  
  var pointOfInterest: JourneyPlanner.PointOfInterest {
    return .init(latitude: latitude, longitude: longitude)
  }
}

class JourneyDetailsViewModel: ObservableObject {
  
  @Published var startLocationTitle: String = "Starting From"
  @Published var startLocation: LocationViewModel.Location?
  @Published var viaLocationTitle: String = "Via"
  @Published var viaLocation: LocationViewModel.Location?
  @Published var destinationTitle: String = "Destination"
  @Published var destination: LocationViewModel.Location?
  @Published var leavingAt: Date = Date.now
  @Published var results: [Journey] = []
  
  func submit() async throws {
    
    guard
      let fromCoordinate = startLocation?.result.placemark.coordinate,
      let toCoordinate = destination?.result.placemark.coordinate
    else {
      return
    }
    
    let transport = URLSessionTransport()
    let journeyPlanner = try TFLJourney.JourneyPlanner(transport: transport)
    
    let viaCoordinate = viaLocation?.result.placemark.coordinate
    
    let result = try await journeyPlanner.getJourneyPlan(from: fromCoordinate.pointOfInterest,
                                                         to: toCoordinate.pointOfInterest,
                                                         via: viaCoordinate?.pointOfInterest,
                                                         leavingAt: leavingAt)
    let journeys = try result.ok.body.json.journeys ?? []
    let results =  journeys.map { Journey(journey: $0) }
    
    await MainActor.run {
    
      self.results = results
    }
  }
}
