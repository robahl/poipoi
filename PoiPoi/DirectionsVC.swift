//
//  ViewController.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-10.
//

import UIKit
import CoreLocation

class DirectionsVC: UIViewController, CLLocationManagerDelegate {
  var locationManager = CLLocationManager()
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var compassView: CompassView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    locationManager.startUpdatingHeading()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      latitudeLabel.text = "Lat: \(location.coordinate.latitude)"
      longitudeLabel.text = "Lon: \(location.coordinate.longitude)"
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    headingLabel.text = "Heading \(newHeading.magneticHeading)"
    
    compassView.needleAngle = newHeading.magneticHeading
    
  }


}

