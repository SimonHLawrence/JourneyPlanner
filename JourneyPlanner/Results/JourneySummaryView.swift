//
//  JourneySummaryView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import SwiftUI

struct JourneySummaryView: View {
  
  var viewModel: JourneySummaryViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(viewModel.modes)
        .accessibilityIdentifier("journeysummaryview")
      Text(viewModel.duration)
    }
  }
}


#Preview {
  JourneySummaryView(viewModel: JourneySummaryViewModel(journey: Journey.mock()))
}
