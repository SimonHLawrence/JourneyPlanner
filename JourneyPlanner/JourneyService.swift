//
//  JourneyService.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 02/04/2024.
//

import Foundation
import CoreLocation
import TFLJourney
import OpenAPIRuntime
import OpenAPIURLSession

extension CLLocationCoordinate2D {
  
  var pointOfInterest: JourneyPlanner.PointOfInterest {
    return .init(latitude: latitude, longitude: longitude)
  }
}

protocol JourneyService {
  
  func getJourneys(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, via: CLLocationCoordinate2D?, leavingAt: Date?) async throws -> [Journey]
}

struct TFLJourneyService: JourneyService {
  
  func getJourneys(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, via: CLLocationCoordinate2D?, leavingAt: Date?) async throws -> [Journey] {
    let transport = URLSessionTransport()
    let journeyPlanner = try TFLJourney.JourneyPlanner(transport: transport)
    
    let result = try await journeyPlanner.getJourneyPlan(from: from.pointOfInterest,
                                                         to: to.pointOfInterest,
                                                         via: via?.pointOfInterest,
                                                         leavingAt: leavingAt)
    let journeys = try result.ok.body.json.journeys ?? []
    
    return journeys.map { Journey(journey: $0) }
  }
}

struct MockJourneyService: JourneyService {
  
  func getJourneys(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, via: CLLocationCoordinate2D?, leavingAt: Date?) async throws -> [Journey] {
    
    return [Journey.mock()]
  }
}
