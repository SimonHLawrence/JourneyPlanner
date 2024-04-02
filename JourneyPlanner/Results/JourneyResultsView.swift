//
//  JourneyResultsView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import SwiftUI

struct JourneyResultsView: View {
  
  var viewModel: JourneyResultsViewModel
  
  var body: some View {
    
    List(viewModel.journeys) { journey in
      NavigationLink(destination: {
        RouteView(viewModel: RouteViewModel(journey: journey))
      }, label: {
        JourneySummaryView(viewModel: JourneySummaryViewModel(journey: journey))
      })
    }
    .accessibilityIdentifier("journeyresultsview")
    .navigationTitle("Results")
  }
}

#Preview {
  NavigationStack {
    JourneyResultsView(viewModel: JourneyResultsViewModel(journeys: [Journey.mock()]))
  }
}
