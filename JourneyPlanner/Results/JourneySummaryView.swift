//
//  JourneySummaryView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import SwiftUI

class JourneySummaryViewModel: ObservableObject {

  @Published var journey: Journey
  @Published var duration: String
  @Published var modes: String
  
  init(journey: Journey) {
    self.journey = journey
    let duration = Duration.seconds(journey.duration)
    let modes = Set(journey.legs.compactMap { $0.mode.capitalized })
    self.modes = modes
      .map { $0.replacingOccurrences(of: "-", with: " ")}
      .joined(separator: ", ")
    self.duration = "Duration \(duration.formatted())"
  }
}

struct JourneySummaryView: View {
  
  var viewModel: JourneySummaryViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(viewModel.modes)
      Text(viewModel.duration)
    }
  }
}


#Preview {
  JourneySummaryView(viewModel: JourneySummaryViewModel(journey: Journey.mock()))
}
