//
//  DepartureView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import SwiftUI

struct DepartureView: View {
  
  @Binding var leaving: Date
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Leaving Today At").font(.title2)
      DatePicker("", selection: $leaving, in: Date()..., displayedComponents: .hourAndMinute)
        .datePickerStyle(.compact)
        .labelsHidden()
        .accessibilityIdentifier("departureview.leavingat")
    }
  }
}

#Preview {
  DepartureView(leaving: .constant(Date.now))
}
