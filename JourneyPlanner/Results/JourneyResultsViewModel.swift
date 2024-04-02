//
//  JourneyResultsViewModel.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 02/04/2024.
//

import Foundation

class JourneyResultsViewModel: ObservableObject {

  @Published var journeys: [Journey]
  
  init(journeys: [Journey]) {
    self.journeys = journeys
  }
}
