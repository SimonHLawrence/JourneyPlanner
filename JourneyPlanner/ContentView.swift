//
//  ContentView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 29/03/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
  
  var viewModel = JourneyDetailsViewModel(journeyService: TFLJourneyService())
  
  var body: some View {
    NavigationStack {
      JourneyDetailsView(viewModel: viewModel)
    }
  }
}

#Preview {
  ContentView()
}
