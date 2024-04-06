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
  @State var searchInProgress: Bool = false
  @State var showingError = false

  var body: some View {
    List {
      LocationSummaryView(title: viewModel.startLocationTitle,
                          locationLookupService: viewModel.locationLookupService, 
                          location: $viewModel.startLocation)
      .accessibilityIdentifier("journeydetailsview.startlocation")
      LocationSummaryView(title: viewModel.viaLocationTitle,
                          isOptional: true,
                          locationLookupService: viewModel.locationLookupService,
                          location: $viewModel.viaLocation)
      .accessibilityIdentifier("journeydetailsview.vialocation")
      
      LocationSummaryView(title: viewModel.destinationTitle,
                          locationLookupService: viewModel.locationLookupService,
                          location: $viewModel.destination)
      .accessibilityIdentifier("journeydetailsview.destination")
      DepartureView(leaving: $viewModel.leavingAt)
        .accessibilityIdentifier("journeydetailsview.leavingat")
    }
    .listStyle(.inset)
    .navigationTitle("Plan a Journey")
    .toolbar(content: {
      Button(action: { findRoutes() }, label: { Text("Find Routes") })
        .disabled(viewModel.startLocation == nil || viewModel.destination == nil)
        .accessibilityIdentifier("journeydetailsview.findroutes")
    })
    .accessibilityIdentifier("journeydetailsview")
    .navigationDestination(isPresented: self.$searchComplete, destination: {
      JourneyResultsView(viewModel: JourneyResultsViewModel(journeys: viewModel.results))
    }).overlay {
      Group {
        if self.searchInProgress {
          VStack {
            ProgressView() {
              Text("Finding routes...")
            }
            .controlSize(.large)
            .padding()
          }
          .background {
            Color(.secondarySystemBackground)
          }
        }
      }
    }
    .navigationDestination(isPresented: $showingError) {
      ContentUnavailableView(viewModel.error ?? "An error occurred.", 
                             systemImage: "figure.walk.motion.trianglebadge.exclamationmark")
      .accessibilityIdentifier("journeydetailsview.error")
    }
  }
  
  func findRoutes() {
    searchInProgress = true
    Task {
      let ok = try await viewModel.submit()
      await MainActor.run {
        searchInProgress = false
        searchComplete = ok
        showingError = !ok
      }
    }
  }
}

#Preview {
  NavigationStack {
    JourneyDetailsView(viewModel: JourneyDetailsViewModel(journeyService: MockJourneyService(), locationLookupService: MapKitLocationLookupService()))
  }
}
