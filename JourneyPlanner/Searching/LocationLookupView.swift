//
//  LocationLookupView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 30/03/2024.
//

import SwiftUI

struct LocationLookupView: View {
  
  @ObservedObject var viewModel: LocationViewModel
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
      
  var body: some View {
    VStack(alignment: .leading) {
      TextField(viewModel.prompt, text: $viewModel.locationText)
        .autocorrectionDisabled()
        .accessibilityIdentifier("locationlookupview.locationtext")
      switch (viewModel.state) {
      case .empty:
        ContentUnavailableView(viewModel.emptyTitle,
                               systemImage: "magnifyingglass")
        .accessibilityIdentifier("locationlookupview.empty")
      case .noResults:
        ContentUnavailableView(viewModel.noResultsTitle,
                               systemImage: "exclamationmark.magnifyingglass")
        .accessibilityIdentifier("locationlookupview.noresults")
      case .ready:
        List(viewModel.resolvedLocations) { location in
          VStack(alignment: .leading) {
            Text(location.name ?? "").font(.headline)
              .accessibilityIdentifier(location.name ?? "locationlookupview.result")
            Text(location.postalAddress).font(.subheadline)
          }.onTapGesture {
            viewModel.selectedLocation = location
            presentationMode.wrappedValue.dismiss()
          }
        }
        .listStyle(.inset)
        .accessibilityIdentifier("locationlookupview")
      }
    }
    .padding()
    .navigationTitle(viewModel.title)
  }
}

#Preview {
  NavigationStack {
    LocationLookupView(viewModel: LocationViewModel(
      title: "Starting Location", 
      locationLookupService: MapKitLocationLookupService(),
      selectedLocation: .constant(nil)))
  }
}
