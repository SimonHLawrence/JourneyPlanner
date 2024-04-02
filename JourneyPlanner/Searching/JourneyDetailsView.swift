//
//  JourneyDetailsView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI

struct JourneyDetailsView: View {
  
  @ObservedObject var viewModel: JourneyDetailsViewModel
  @State var searchComplete: Bool = false
  
  var body: some View {
    List {
      LocationSummaryView(title: viewModel.startLocationTitle,
                          location: $viewModel.startLocation)
      LocationSummaryView(title: viewModel.viaLocationTitle,
                          isOptional: true,
                          location: $viewModel.viaLocation)
      LocationSummaryView(title: viewModel.destinationTitle,
                          location: $viewModel.destination)
      DepartureView(leaving: $viewModel.leavingAt)
    }
    .listStyle(.inset)
    .navigationTitle("Plan a Journey")
    .toolbar(content: {
      Button(action: { findRoutes() }, label: { Text("Find Routes") })
        .disabled(viewModel.startLocation == nil || viewModel.destination == nil)
    })
    .navigationDestination(isPresented: self.$searchComplete, destination: {
      JourneyResultsView(viewModel: JourneyResultsViewModel(journeys: viewModel.results))
    })
  }
  
  func findRoutes() {
    Task {
      try await viewModel.submit()
      await MainActor.run {
        searchComplete = true
      }
    }
  }
}

#Preview {
  NavigationStack {
    JourneyDetailsView(viewModel: JourneyDetailsViewModel(journeyService: MockJourneyService()))
  }
}
