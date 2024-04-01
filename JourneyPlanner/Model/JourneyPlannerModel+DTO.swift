//
//  JourneyPlannerModel+DTO.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import Foundation
import CoreLocation
import TFLJourney

typealias DTOJourney = TFLJourney.Components.Schemas.Tfl_hyphen_29
typealias DTOLeg = TFLJourney.Components.Schemas.Tfl_hyphen_23
typealias DTOInstruction = TFLJourney.Components.Schemas.Tfl_hyphen_4
typealias DTOStep = TFLJourney.Components.Schemas.Tfl_hyphen_3

extension TimeInterval {
  
  static func fromMinutes(_ value: Int32?) -> TimeInterval {
    Double(value ?? 0) * 60.0
  }
}

extension Step {
  
  init(step: DTOStep) {
    var coordinate: CLLocationCoordinate2D?
    if let latitude = step.latitude, let longitude = step.longitude {
      coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    self.init(coordinate: coordinate,
              turnDirection: step.turnDirection,
              stepDescription: step.description)
  }
}

extension Instruction {
  
  init?(instruction: DTOInstruction?) {
    guard let instruction else {
      return nil
    }
    
    self.init(summary: instruction.summary,
              detailed: instruction.detailed,
              steps: instruction.steps?.map { .init(step: $0) })
  }
}

let squareBrackets = CharacterSet(charactersIn: "[]")

extension Leg {
  
  init(leg: DTOLeg) {
    
    self.init(duration: TimeInterval.fromMinutes(leg.duration),
              departure: leg.departureTime ?? Date.distantPast,
              arrival: leg.arrivalTime ?? Date.distantFuture,
              mode: leg.mode?.name ?? "",
              path: Leg.pathFromLineString(leg.path?.lineString),
              instruction: .init(instruction: leg.instruction))
  }

  static func pathFromLineString(_ value: String?) -> [CLLocationCoordinate2D] {
    
    guard let value, !value.isEmpty else {
      return []
    }
    
    let pathComponents = value
      .components(separatedBy: squareBrackets)
      .filter { !($0.isEmpty || $0 == " " || $0 == ",")}
    
    var result: [CLLocationCoordinate2D] = []
    result.reserveCapacity(pathComponents.count)
    
    let trim: (String.SubSequence) -> String = { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    for component in pathComponents {
      let coordinateStrings = component.split(separator: ",")
      if coordinateStrings.count == 2,
         let latitude = Double(trim(coordinateStrings[0])),
         let longitude = Double(trim(coordinateStrings[1])) {
      
        result.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
      }
    }
    
    return result
  }
}

extension Journey {
  
  init(journey: DTOJourney) {
    
    let legs: [Leg] = journey.legs?.compactMap { .init(leg: $0) } ?? []
    
    self.init(duration: TimeInterval.fromMinutes(journey.duration),
              start: journey.startDateTime ?? Date.distantPast,
              arrival: journey.arrivalDateTime ?? Date.distantFuture,
              legs: legs)
  }
}
