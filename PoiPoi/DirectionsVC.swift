//
//  ViewController.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-10.
//

import UIKit
import CoreLocation

class DirectionsVC: UIViewController, CLLocationManagerDelegate {
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var compassView: CompassView!
  
  var locationManager = CLLocationManager()
  var lastLocation: CLLocation?
  var trackingPoi: PoiLocation?
  
  override func viewDidAppear(_ animated: Bool) {
    trackingPoi = State.shared.trackingPoi
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    locationManager.startUpdatingHeading()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      lastLocation = location
      
      if let trackingPoi = trackingPoi {
        let distance = CLLocation(latitude: trackingPoi.latitude, longitude: trackingPoi.longitude).distance(from: location)
        distanceLabel.text = "Distance: \(distance)"
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    let magneticHeading  = Int(round(newHeading.magneticHeading))
    var t: Float = 0.0
    var diff: CLLocationDirection = 0
    
    if let poi = trackingPoi {
      t = getHeadingFrom(lastLocation!, to: CLLocation(latitude: poi.latitude, longitude: poi.longitude))
      diff = getHeadingDifferenceFrom(newHeading.magneticHeading, to: CLLocationDirection(t))
    }
    
    // For debugging purpose
    headingLabel.text = "H: \(magneticHeading) - L: \(t) D: \(diff)"
    
    compassView.needleAngle = Float(diff)
    
  }
  
  func getHeadingFrom(_ from: CLLocation, to: CLLocation) -> Float {
    let radius = 6371 // earth radius in km
    
    let deltaLat = to.coordinate.latitude - from.coordinate.latitude
    let deltaLon = to.coordinate.longitude - from.coordinate.longitude
    
    let a = pow(sin(deltaLat/2), 2) + cos(from.coordinate.latitude) * cos(to.coordinate.latitude) * pow(sin(deltaLon/2), 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    
    
    return (Float(radius) * Float(c)) * 180 / .pi // degrees instead of radians
  }
  
  func getHeadingDifferenceFrom(_ from: CLLocationDirection, to: CLLocationDirection) -> CLLocationDirection {
    let diff = from - to
    let absDiff = abs(diff)
    
    if (absDiff <= 180) {
      return absDiff == 180 ? absDiff : diff
    }
    
    if (to > from) {
      return absDiff - 360
    }
    
    return 360 - absDiff
  }
  
  @IBAction func poiPressed(_ sender: UIButton) {
    // Store the last location immediately
    if let location = lastLocation {
      
      let alert = UIAlertController(title: "POI", message: "Enter a name", preferredStyle: .alert)
      alert.addTextField { (textField) in
        textField.placeholder = "Some default text"
      }
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
        let textField = alert?.textFields![0]
        
        State.shared.poiLocations.append(PoiLocation(name: textField?.text ?? "Untitled", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        // Navigate to the locations table view
        self.tabBarController?.selectedIndex = 0
      }))
      
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

