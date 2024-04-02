//
//  Extensions.swift
//  JourneyPlannerUITests
//
//  Created by Simon Lawrence on 02/04/2024.
//

import Foundation
import XCTest

extension XCTestCase {
  
  func element(app: XCUIApplication, identifier: String) -> XCUIElement {
    
    return app.descendants(matching: .any).matching(NSPredicate(format: "identifier == '\(identifier)'")).firstMatch
  }
  
  func element(app: XCUIApplication, parent: XCUIElement, identifier: String) -> XCUIElement {
    
    return app.descendants(matching: .any).matching(NSPredicate(format: "identifier == '\(identifier)'")).firstMatch
  }
}

