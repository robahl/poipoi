//
//  LocationHelpers.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-23.
//

import UIKit
import CoreLocation

extension CLLocationDirection {
  var toRadians: CLLocationDirection { return self * .pi / 180 }
  var toDegrees: CLLocationDirection { return self * 180 / .pi }
}

extension CLLocation {
  func bearingTo(_ destinationLocation: CLLocation) -> CLLocationDirection {
    
    let lat1 = self.coordinate.latitude.toRadians
    let lon1 = self.coordinate.longitude.toRadians
    
    let lat2 = destinationLocation.coordinate.latitude.toRadians
    let lon2 = destinationLocation.coordinate.longitude.toRadians
    
    let dLon = lon2 - lon1
    
    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
    let radiansBearing = atan2(y, x)
    
    return radiansBearing.toDegrees
    
  }
}
