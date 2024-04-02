//
//  JourneySummaryViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 02/04/2024.
//

import Foundation

class JourneySummaryViewModel: ObservableObject {

  @Published var journey: Journey
  @Published var duration: String
  @Published var modes: String
  
  init(journey: Journey) {
    self.journey = journey
    let duration = Duration.seconds(journey.duration)
    let modes = Set(journey.legs.compactMap { $0.mode.capitalized })
    self.modes = modes
      .sorted()
      .map { $0.replacingOccurrences(of: "-", with: " ")}
      .joined(separator: ", ")
    self.duration = "Duration \(duration.formatted())"
  }
}
