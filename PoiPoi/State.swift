//
//  State.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-15.
//

import Foundation
import CoreLocation

class State {
  static let shared = State()
  
  var poiLocations: [PoiLocation] = []
  var trackingPoi: PoiLocation?
}

struct PoiLocation {
  var name: String
  var location: CLLocation
}
