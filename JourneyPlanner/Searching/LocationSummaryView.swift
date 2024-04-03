//
//  LocationSummaryView.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 31/03/2024.
//

import SwiftUI

struct LocationSummaryView: View {
  
  var title: String
  var isOptional: Bool = false
  var locationLookupService: LocationLookupService
  @Binding var location: Location?
  
  var body: some View {
    NavigationLink(destination: {
      LocationLookupView(viewModel: LocationViewModel(title: title, locationLookupService: locationLookupService, selectedLocation: $location))
    }, label: {
      HStack {
        
        VStack(alignment: .leading) {
          Text(title)
            .font(.title2)
          if let location = location {
            if let name = location.name {
              Text(name).font(.headline)
            }
            Text(location.postalAddress).font(.subheadline)
          } else {
            Text("Tap to select a location.").font(.body).fontWeight(.light)
          }
        }
        if isOptional {
          Spacer()
          Button(action: { location = nil }, label: { Text("Clear") } )
            .buttonStyle(.plain)
            .disabled(location == nil)
        }
      }
    })
  }
}


#Preview {
  NavigationStack {
    List {
      LocationSummaryView(title: "My Location", isOptional: true, locationLookupService: MapKitLocationLookupService(), location: .constant(nil))
    }
  }
}
