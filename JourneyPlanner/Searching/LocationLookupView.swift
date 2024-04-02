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
      TextField("Enter a London address...", text: $viewModel.locationText)
        .accessibilityIdentifier("locationlookupview.locationtext")
      List(viewModel.resolvedLocations) { location in
        VStack(alignment: .leading) {
          Text(location.result.name ?? "").font(.headline)
          Text(location.postalAddress).font(.subheadline)
        }.onTapGesture {
          viewModel.selectedLocation = location
          presentationMode.wrappedValue.dismiss()
        }.accessibilityIdentifier(location.result.name ?? "locationlookupview.result")
      }.listStyle(.inset)
    }
    .padding()
    .navigationTitle(viewModel.title)
  }
}

#Preview {
  NavigationStack {
    LocationLookupView(viewModel: LocationViewModel(title: "Starting Location", selectedLocation: .constant(nil)))
  }
}
