//
//  JourneyPlannerModelTests.swift
//  JourneyPlannerTests
//
//  Created by Simon Lawrence on 06/04/2024.
//

import XCTest
import CoreLocation
@testable import JourneyPlanner

final class JourneyPlannerModelTests: XCTestCase {
  
  func testCoordinateHashing() throws {
    
    let coordinate1 = CLLocationCoordinate2D(latitude: 51.53458963295, longitude: 51.53458963295)
    let coordinate2 = CLLocationCoordinate2D(latitude: 51.53458970429, longitude: -0.13892847421)
    
    var hasher1 = Hasher()
    hasher1.combine(coordinate1)
    let result1 = hasher1.finalize()
    
    var hasher2 = Hasher()
    hasher2.combine(coordinate2)
    let result2 = hasher2.finalize()
    
    var hasher3 = Hasher()
    hasher3.combine(coordinate1)
    let result3 = hasher3.finalize()
    
    XCTAssertEqual(result1, result3)
    XCTAssertNotEqual(result1, result2)
  }
  
  func testLegParsing() throws {
    
    let expectedResults: [(String?, [CLLocationCoordinate2D])] = [
      (nil, []),
      ("", []),
      ("[[51.53458963295, 51.53458963295],[51.53458970429, -0.13892847421],[51.53463365185, -0.13886303633],[51.53474888523, -0.13889423365],[51.53475116429, -0.13890149957]]",
       [
        CLLocationCoordinate2D(latitude: 51.53458963295, longitude: 51.53458963295),
        CLLocationCoordinate2D(latitude: 51.53458970429, longitude: -0.13892847421),
        CLLocationCoordinate2D(latitude: 51.53463365185, longitude: -0.13886303633),
        CLLocationCoordinate2D(latitude: 51.53474888523, longitude: -0.13889423365),
        CLLocationCoordinate2D(latitude: 51.53475116429, longitude: -0.13890149957)
       ]
      )
    ]
    
    for (lineString, expectedPath) in expectedResults {
      let path = Leg.pathFromLineString(lineString)
      XCTAssertEqual(path, expectedPath)
    }
  }
}
