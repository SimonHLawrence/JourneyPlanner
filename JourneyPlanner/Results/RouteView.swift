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
    var steps: [Step]
  }
  
  @Published var journey: Journey
  @Published var routes: [Route]
  @Published var steps: [Step]
  
  init(journey: Journey) {
    self.journey = journey
    let routes = journey.legs.map { leg in
      
      return Route(mode: leg.mode,
                   title: leg.instruction?.summary ?? leg.mode.capitalized,
                   coordinates: leg.path,
                   steps: leg.instruction?.steps ?? [])
    }
    
    self.steps = routes.reduce([], { $0 + $1.steps }).filter { $0.coordinate != nil }
    self.routes = routes
  }
  
  func format(step: Step) -> String {
    return "\(step.turnDirection ?? "") \(step.stepDescription ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func imageFor(mode: String) -> String {
    switch mode {
    case "national-rail", "tube", "elizabeth-line", "overground":
      return "train.side.rear.car"
    case "bus":
      return "bus.doubledecker"
    default:
      return "figure.walk.circle.fill"
    }
  }
}

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
        Marker(viewModel.format(step: step), systemImage: "figure.walk.circle.fill", coordinate: step.coordinate!)
          .tint(.green)
      }
      if let destination = viewModel.routes.last?.coordinates.last {
        Marker("Destination", systemImage: "flag.checkered", coordinate: destination)
          .tint(.blue)
      }
    }.navigationTitle("Route")
  }
}

#Preview {
  NavigationStack {
    RouteView(viewModel: RouteViewModel(journey: Journey.mock()))
  }
}
