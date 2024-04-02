//
//  JourneyPlannerApp.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 29/03/2024.
//

import SwiftUI

func createJourneyService() -> JourneyService {
  if let isUITest = ProcessInfo.processInfo.environment["XCUITest"],
     isUITest == "YES" {
    return MockJourneyService()
  }
  return TFLJourneyService()
}

@main
struct JourneyPlannerApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: JourneyDetailsViewModel(journeyService: createJourneyService()))
    }
  }
}
