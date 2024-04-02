//
//  JourneyPlannerModel+Mocks.swift
//  JourneyPlanner
//
//  Created by Simon Lawrence on 01/04/2024.
//

import Foundation
import CoreLocation

protocol Mock {
  
  static func mock() -> Self
}

let journeyDuration: TimeInterval = 31 * 60
let now = Date(timeIntervalSinceReferenceDate: 733664348)
let future = now.addingTimeInterval(journeyDuration)

extension Instruction: Mock {
  
  static func mock() -> Instruction {
    
    return Instruction(
      summary: "Walk to 1 Lakeside Terrace",
      detailed: "Walk to 1 Lakeside Terrace",
      steps: [
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "Clink Street for 67 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.507097205870004,
            longitude: -0.091769005759999994
          )
        ),
        Step(
          turnDirection: "RIGHT",
          stepDescription: "on to Bank End, continue for 24 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.507103913869997,
            longitude: -0.09273420798000001
          )
        ),
        Step(
          turnDirection: "SLIGHT LEFT",
          stepDescription: "on to Bankside, continue for 407 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.507319354900005,
            longitude: -0.09271080089
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "for 31 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.508306869039998,
            longitude: -0.098145573329999999
          )
        ),
        Step(
          turnDirection: "RIGHT",
          stepDescription: "on to Millennium Bridge, continue for 330 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.508278161519996,
            longitude: -0.098593495710000006
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "on to Peter\'s Hill, continue for 76 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.511243470949999,
            longitude: -0.098455618369999997
          )
        ),
        Step(
          turnDirection: "RIGHT",
          stepDescription: "on to Queen Victoria Street, continue for 213 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.511925743709995,
            longitude: -0.098383972439999994
          )
        ),
        Step(
          turnDirection: "LEFT",
          stepDescription: "on to Bread Street, continue for 54 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.512074370389996,
            longitude: -0.095351316229999997
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "for 12 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.51253909415,
            longitude: -0.095173401509999991
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "on to Bread Street, continue for 178 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.512646697899996,
            longitude: -0.09515450092000001
          )
        ),
        Step(
          turnDirection: "LEFT",
          stepDescription: "on to Cheapside, continue for 19 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.514181842600003,
            longitude: -0.094441900620000005
          )
        ),
        Step(
          turnDirection: "RIGHT",
          stepDescription: "on to Wood Street, continue for 163 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.51422223414,
            longitude: -0.094714051120000003
          )
        ),
        Step(
          turnDirection: "LEFT",
          stepDescription: "on to Gresham Street, continue for 15 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.515674297689998,
            longitude: -0.09442285193000001
          )
        ),
        Step(
          turnDirection: "RIGHT",
          stepDescription: "on to Wood Street, continue for 209 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.515713519469998,
            longitude: -0.094622995599999996
          )
        ),
        Step(
          turnDirection: "SHARP LEFT",
          stepDescription: "on to London Wall, continue for 10 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.51747856195,
            longitude: -0.093670113220000004
          )
        ),
        Step(
          turnDirection: "SLIGHT RIGHT",
          stepDescription: "for 8 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.517480902910002,
            longitude: -0.093814150080000006
          )
        ),
        Step(
          turnDirection: "SLIGHT RIGHT",
          stepDescription: "on to Alban Highwalk, continue for 84 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.517527239689997,
            longitude: -0.093898696290000014
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "on to The Postern, continue for 76 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.518230848899996,
            longitude: -0.093480150200000001
          )
        ),
        Step(
          turnDirection: "SLIGHT LEFT",
          stepDescription: "on to Gilbert Bridge, continue for 86 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.518872019619998,
            longitude: -0.093093026780000004
          )
        ),
        Step(
          turnDirection: "STRAIGHT",
          stepDescription: "on to Lakeside Terrace, continue for 67 metres",
          coordinate: CLLocationCoordinate2D(
            latitude: 51.519493021449996,
            longitude: -0.093124743689999998
          )
        )
      ])
  }
}

extension Leg: Mock {
  
  static func mock() -> Leg {
    return JourneyPlanner.Leg(
      duration: 1860.0,
      departure:now,
      arrival: future,
      mode: "walking",
      path: [
        CLLocationCoordinate2D(latitude: 51.50709697156, longitude: -0.09175460537),
        CLLocationCoordinate2D(latitude: 51.50709595254, longitude: -0.09176901144),
        CLLocationCoordinate2D(latitude: 51.50708860372, longitude: -0.09234577244),
        CLLocationCoordinate2D(latitude: 51.50710391387, longitude: -0.09273420798),
        CLLocationCoordinate2D(latitude: 51.5073193549, longitude: -0.09271080089),
        CLLocationCoordinate2D(latitude: 51.50746047442, longitude: -0.09309398566),
        CLLocationCoordinate2D(latitude: 51.50765246812, longitude: -0.09328771441),
        CLLocationCoordinate2D(latitude: 51.5079686817, longitude: -0.09448499116),
        CLLocationCoordinate2D(latitude: 51.50802657787, longitude: -0.09472755362),
        CLLocationCoordinate2D(latitude: 51.50822956131, longitude: -0.09559812831),
        CLLocationCoordinate2D(latitude: 51.50833158338, longitude: -0.09634322358),
        CLLocationCoordinate2D(latitude: 51.50834594559, longitude: -0.09667406805),
        CLLocationCoordinate2D(latitude: 51.50834724049, longitude: -0.09730807916),
        CLLocationCoordinate2D(latitude: 51.50830686904, longitude: -0.09814557333),
        CLLocationCoordinate2D(latitude: 51.50827816152, longitude: -0.09859349571),
        CLLocationCoordinate2D(latitude: 51.50844890495, longitude: -0.09858638708),
        CLLocationCoordinate2D(latitude: 51.50958120332, longitude: -0.09853924389),
        CLLocationCoordinate2D(latitude: 51.51048008613, longitude: -0.09851622798),
        CLLocationCoordinate2D(latitude: 51.510650596, longitude: -0.09849471693),
        CLLocationCoordinate2D(latitude: 51.51074944741, longitude: -0.09849060085),
        CLLocationCoordinate2D(latitude: 51.51124347095, longitude: -0.09845561837),
        CLLocationCoordinate2D(latitude: 51.51192574371, longitude: -0.09838397244),
        CLLocationCoordinate2D(latitude: 51.51191325439, longitude: -0.09816831713),
        CLLocationCoordinate2D(latitude: 51.51190146536, longitude: -0.09799586784),
        CLLocationCoordinate2D(latitude: 51.51188009793, longitude: -0.09723293856),
        CLLocationCoordinate2D(latitude: 51.51190646273, longitude: -0.09664096052),
        CLLocationCoordinate2D(latitude: 51.51191789077, longitude: -0.09623695663),
        CLLocationCoordinate2D(latitude: 51.51200996187, longitude: -0.09581517803),
        CLLocationCoordinate2D(latitude: 51.51206037316, longitude: -0.09559689972),
        CLLocationCoordinate2D(latitude: 51.51207437039, longitude: -0.09535131623),
        CLLocationCoordinate2D(latitude: 51.51229027963, longitude: -0.09535672243),
        CLLocationCoordinate2D(latitude: 51.51253909415, longitude: -0.09517340151),
        CLLocationCoordinate2D(latitude: 51.5126466979, longitude: -0.09515450092),
        CLLocationCoordinate2D(latitude: 51.51322684177, longitude: -0.09488529381),
        CLLocationCoordinate2D(latitude: 51.51341415392, longitude: -0.09479100571),
        CLLocationCoordinate2D(latitude: 51.51368211024, longitude: -0.09467893954),
        CLLocationCoordinate2D(latitude: 51.51391412055, longitude: -0.09456837204),
        CLLocationCoordinate2D(latitude: 51.5141818426, longitude: -0.09444190062),
        CLLocationCoordinate2D(latitude: 51.51422223414, longitude: -0.09471405112),
        CLLocationCoordinate2D(latitude: 51.51450886519, longitude: -0.09464444065),
        CLLocationCoordinate2D(latitude: 51.51466140113, longitude: -0.09462366287),
        CLLocationCoordinate2D(latitude: 51.5149040357, longitude: -0.09461353772),
        CLLocationCoordinate2D(latitude: 51.51567429769, longitude: -0.09442285193),
        CLLocationCoordinate2D(latitude: 51.51571351947, longitude: -0.0946229956),
        CLLocationCoordinate2D(latitude: 51.51656919948, longitude: -0.09415489089),
        CLLocationCoordinate2D(latitude: 51.51678417238, longitude: -0.09410267752),
        CLLocationCoordinate2D(latitude: 51.51691686275, longitude: -0.09396741889),
        CLLocationCoordinate2D(latitude: 51.51715785861, longitude: -0.09385646433),
        CLLocationCoordinate2D(latitude: 51.51746082314, longitude: -0.09368526736),
        CLLocationCoordinate2D(latitude: 51.51747856195, longitude: -0.09367011322),
        CLLocationCoordinate2D(latitude: 51.51748090291, longitude: -0.09381415008),
        CLLocationCoordinate2D(latitude: 51.51752723969, longitude: -0.09389869629),
        CLLocationCoordinate2D(latitude: 51.51785692952, longitude: -0.09371196867),
        CLLocationCoordinate2D(latitude: 51.5182308489, longitude: -0.0934801502),
        CLLocationCoordinate2D(latitude: 51.51857804257, longitude: -0.09326385788),
        CLLocationCoordinate2D(latitude: 51.51887201962, longitude: -0.09309302678),
        CLLocationCoordinate2D(latitude: 51.51891788858, longitude: -0.09314876651),
        CLLocationCoordinate2D(latitude: 51.51898032539, longitude: -0.09311733074),
        CLLocationCoordinate2D(latitude: 51.5194438737, longitude: -0.0928673431),
        CLLocationCoordinate2D(latitude: 51.51949302145, longitude: -0.09312474369),
        CLLocationCoordinate2D(latitude: 51.51952185417, longitude: -0.0932388522),
        CLLocationCoordinate2D(latitude: 51.51958991053, longitude: -0.09355312046),
        CLLocationCoordinate2D(latitude: 51.51968495713, longitude: -0.09403388241),
        CLLocationCoordinate2D(latitude: 51.51968773435, longitude: -0.09403911663)],
      instruction: Instruction.mock())
  }
}

extension Journey: Mock {
  
  static func mock() -> Journey {
    
    return Journey(duration: journeyDuration, start: now, arrival: future, legs: [Leg.mock()])
  }
}
