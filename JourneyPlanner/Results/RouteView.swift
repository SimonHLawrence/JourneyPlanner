//
//  RouteView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 29/03/2024.
//

import SwiftUI
import MapKit

struct RouteView: View {
  
  @ObservedObject var viewModel: RouteViewModel
  
  var body: some View {
    Map {
      ForEach(viewModel.routes) { route in
        if let start = route.coordinates.first {
          Marker(route.title, systemImage: viewModel.imageFor(mode: route.mode), coordinate: start)
            .tint(.orange)
        }
        MapPolyline(coordinates: route.coordinates)
          .stroke(.blue, lineWidth: 4.0)
      }
      ForEach(viewModel.steps) { step in
        Marker(viewModel.format(step: step), systemImage: viewModel.stepImage, coordinate: step.coordinate!)
          .tint(.green)
      }
      if let destination = viewModel.routes.last?.coordinates.last {
        Marker(viewModel.destinationTitle, systemImage: viewModel.destinationImage, coordinate: destination)
          .tint(.blue)
      }
    }
    .accessibilityIdentifier("routeview")
    .navigationTitle(viewModel.title)
  }
}

#Preview {
  NavigationStack {
    RouteView(viewModel: RouteViewModel(journey: Journey.mock()))
  }
}
