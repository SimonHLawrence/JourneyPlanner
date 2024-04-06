//
//  SearchInProgressView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 06/04/2024.
//

import SwiftUI

struct SearchInProgressView: View {
  var body: some View {
    VStack {
      ProgressView() {
        Text("Finding routes...")
      }
      .controlSize(.large)
      .padding()
    }
    .background {
      #if os(iOS)
      Color(.secondarySystemBackground)
      #endif
    }
    .cornerRadius(16.0)
  }
}

#Preview {
  SearchInProgressView()
}
