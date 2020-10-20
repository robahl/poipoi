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
  let encoder = JSONEncoder()
  
  var poiLocations: [PoiLocation] = [] {
    didSet {
      if let encoded = try? encoder.encode(poiLocations) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "PoiLocations")
      }
    }
  }
  var trackingPoi: PoiLocation?
}

struct PoiLocation: Codable {
  var name: String
  var latitude: Double
  var longitude: Double
}
