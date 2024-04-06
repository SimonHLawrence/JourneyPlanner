//
//  RouteViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 02/04/2024.
//

import Foundation
import MapKit

class RouteViewModel: ObservableObject {
  
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
  
  var stepImage: String {
    "figure.walk.circle.fill"
  }
  
  var destinationImage: String {
    "flag.checkered"
  }
  
  var destinationTitle: String {
    "Destination"
  }
  
  var title: String {
    "Route"
  }
}
