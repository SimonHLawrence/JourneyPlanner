//
//  JourneyPlannerModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import Foundation
import CoreLocation

struct Step: Hashable, Equatable {
  var turnDirection: String?
  var stepDescription: String?
  var coordinate: CLLocationCoordinate2D?
  
  init(coordinate: CLLocationCoordinate2D? = nil, turnDirection: String? = nil, stepDescription: String? = nil) {
    self.coordinate = coordinate
    self.turnDirection = turnDirection
    self.stepDescription = stepDescription
  }
}

struct Instruction: Hashable, Equatable {
  var summary: String?
  var detailed: String?
  var steps: [Step]?
  
  init(summary: String? = nil, detailed: String? = nil, steps: [Step]? = nil) {
    self.summary = summary
    self.detailed = detailed
    self.steps = steps
  }
}

extension CLLocationCoordinate2D: Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}

extension CLLocationCoordinate2D: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(latitude)
    hasher.combine(longitude)
  }
}

struct Leg: Identifiable, Hashable, Equatable {
  
  var id: UUID
  var duration: TimeInterval
  var departure: Date
  var arrival: Date
  var mode: String
  var path: [CLLocationCoordinate2D]
  var instruction: Instruction?
  
  init(id: UUID = UUID(), duration: TimeInterval, departure: Date, arrival: Date, mode: String, path: [CLLocationCoordinate2D], instruction: Instruction? = nil) {
    self.id = id
    self.duration = duration
    self.departure = departure
    self.arrival = arrival
    self.mode = mode
    self.path = path
    self.instruction = instruction
  }
}

struct Journey: Identifiable, Hashable, Equatable {
  
  var id: UUID
  var duration: TimeInterval
  var start: Date
  var arrival: Date
  var legs: [Leg]

  init(id: UUID = UUID(), duration: TimeInterval, start: Date, arrival: Date, legs: [Leg]) {
    self.id = id
    self.duration = duration
    self.start = start
    self.arrival = arrival
    self.legs = legs
  }
}
