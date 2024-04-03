//
//  JourneyPlannerApp.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 29/03/2024.
//

import SwiftUI

func isMocking() -> Bool {
  if let isUITest = ProcessInfo.processInfo.environment["XCUITest"],
     isUITest == "YES" {
    return true
  }
  return false
}

func createJourneyService() -> JourneyService {
  
  isMocking() ? MockJourneyService() : TFLJourneyService()
}

func createLocationLookupService() -> LocationLookupService {
  
  isMocking() ? MockLocationLookupService() : MapKitLocationLookupService()
}

@main
struct JourneyPlannerApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: JourneyDetailsViewModel(journeyService: createJourneyService(), 
                                                     locationLookupService: createLocationLookupService()))
    }
  }
}
