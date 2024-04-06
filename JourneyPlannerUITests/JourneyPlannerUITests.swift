//
//  JourneyPlannerUITests.swift
//  JourneyPlannerUITests
//
//  Created by Simon Lawrence on 29/03/2024.
//

import XCTest

let defaultTimeout: TimeInterval = 60.0

final class JourneyPlannerUITests: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  override func tearDownWithError() throws { }
  
  func testJourneyPlanner() throws {
    
    let app = XCUIApplication()
    app.launchEnvironment = ["XCUITest": "YES"]
    app.launch()
    XCTAssert(app.wait(for: .runningForeground, timeout: defaultTimeout))
    enterJourney(app: app, from: "Clink St", to: "Barbican Centre", via: "Millennium Bridge")
    openFirstRoute(app: app)
  }
  
  func testJourneyPlannerNoLocationResults() throws {
    
    let app = XCUIApplication()
    app.launchEnvironment = ["XCUITest": "YES"]
    app.launch()
    XCTAssert(app.wait(for: .runningForeground, timeout: defaultTimeout))
    let journeyDetails = element(app: app, identifier: "journeydetailsview")
    XCTAssert(journeyDetails.waitForExistence(timeout: defaultTimeout))
    let startLocation = element(app: app, parent: journeyDetails, identifier: "journeydetailsview.startlocation")
    startLocation.tap()
    let lookupTextField = app.textFields["locationlookupview.locationtext"]
    XCTAssert(lookupTextField.waitForExistence(timeout: defaultTimeout))
    lookupTextField.tap()
    lookupTextField.typeText("FEOJZXXXXFOJWSSSSS!!!!")
    let noResults = element(app: app, identifier: "locationlookupview.noresults")
    XCTAssert(noResults.waitForExistence(timeout: defaultTimeout))
  }
  
  func testJourneyPlannerInvalidRoute() throws {
    
    let app = XCUIApplication()
    app.launchEnvironment = ["XCUITest": "YES"]
    app.launch()
    XCTAssert(app.wait(for: .runningForeground, timeout: defaultTimeout))
    enterJourney(app: app, from: "Clink St", to: "Clink St")
    let errorView = element(app: app, identifier: "journeydetailsview.error")
    XCTAssert(errorView.waitForExistence(timeout: defaultTimeout))
  }
  
  func enterJourney(app: XCUIApplication, from: String, to: String, via: String? = nil) {
    
    let journeyDetails = element(app: app, identifier: "journeydetailsview")
    XCTAssert(journeyDetails.waitForExistence(timeout: defaultTimeout))
    let startLocation = element(app: app, parent: journeyDetails, identifier: "journeydetailsview.startlocation")
    enterLocation(app: app, from: startLocation, locationText: from)
    if let via {
      let viaLocation = element(app: app, parent: journeyDetails, identifier: "journeydetailsview.vialocation")
      enterLocation(app: app, from: viaLocation, locationText: via)
    }
    let destination = element(app: app, identifier: "journeydetailsview.destination")
    enterLocation(app: app, from: destination, locationText: to)

    let findButton = app.buttons["journeydetailsview.findroutes"]
    findButton.firstMatch.tap()
  }
  
  func enterLocation(app: XCUIApplication, from: XCUIElement, locationText: String) {
    
    from.tap()
    let lookupTextField = app.textFields["locationlookupview.locationtext"]
    XCTAssert(lookupTextField.waitForExistence(timeout: defaultTimeout))
    lookupTextField.tap()
    lookupTextField.typeText(locationText)
    let locationResult = app.staticTexts[locationText].firstMatch
    XCTAssert(locationResult.waitForExistence(timeout: defaultTimeout))
    locationResult.tap()
    XCTAssert(from.waitForExistence(timeout: defaultTimeout))
  }
  
  func openFirstRoute(app: XCUIApplication) {
    
    let results = element(app: app, identifier: "journeyresultsview")
    XCTAssert(results.waitForExistence(timeout: defaultTimeout))
    let firstRoute = element(app: app, parent: results, identifier: "journeysummaryview").firstMatch
    XCTAssert(firstRoute.waitForExistence(timeout: defaultTimeout))
    firstRoute.tap()
    let routeView = element(app: app, identifier: "routeview")
    XCTAssert(routeView.waitForExistence(timeout: defaultTimeout))
  }
}
