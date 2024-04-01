//
//  RouteView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 29/03/2024.
//

import SwiftUI
import MapKit

class RouteViewModel: ObservableObject {

  struct Route: Identifiable {
    var id: UUID = UUID()
    var mode: String
    var title: String
    var coordinates: [CLLocationCoordinate2D]
  }
  
  @Published var journey: Journey
  @Published var routes: [Route]
  
  init(journey: Journey) {
    self.journey = journey
    self.routes = journey.legs.map { leg in
      
      return Route(mode: leg.mode,
                   title: leg.instruction?.summary ?? leg.mode.capitalized,
                   coordinates: leg.path)
    }
  }
}

struct RouteView: View {
  
  @ObservedObject var viewModel: RouteViewModel
  
  var body: some View {
    Map {
      ForEach(viewModel.routes) { route in
        if let start = route.coordinates.first {
          Marker(route.title, coordinate: start)
        }
        MapPolyline(coordinates: route.coordinates)
          .stroke(.blue, lineWidth: 4.0)
      }
      if let destination = viewModel.routes.last?.coordinates.last {
        Marker("Destination", coordinate: destination)
      }
    }.navigationTitle("Route")
  }
}

#Preview {
  NavigationStack {
    RouteView(viewModel: RouteViewModel(journey: Journey.mock()))
  }
}
