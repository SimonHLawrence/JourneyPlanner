//
//  JourneyPlannerIntegrationTests.swift
//  JourneyPlannerTests
//
//  Created by Simon Lawrence on 29/03/2024.
//

import XCTest
import CoreLocation
@testable import JourneyPlanner

struct WellKnownCoordinates {
  static let londonWaterloo = CLLocationCoordinate2D(latitude: 51.5032, longitude: -0.1123)
  static let londonVictoria = CLLocationCoordinate2D(latitude: 51.4952, longitude: -0.1439)
  static let claphamJunction = CLLocationCoordinate2D(latitude: 51.4652, longitude: -0.1708)
}

final class JourneyPlannerIntegrationTests: XCTestCase {
  
  func testJourneyPlannerService() async throws {
    
    let service = TFLJourneyService()
    let journeys = try await service.getJourneys(from: WellKnownCoordinates.londonWaterloo, to: WellKnownCoordinates.londonVictoria, via: WellKnownCoordinates.claphamJunction, leavingAt: Date.now)
    
    XCTAssertFalse(journeys.isEmpty)
  }
  
  func testLocationLookupService() async throws {
    
    let service = MapKitLocationLookupService()
    let results = try await service.performSearch(location: "Clink St")
    
    XCTAssertFalse(results.isEmpty)
    
    if let firstResult = results.first {
      let postalAddress = firstResult.postalAddress
      let postcodeRange = postalAddress.range(of: "SE1")
      XCTAssertNotNil(postcodeRange)
    }
  }
}
