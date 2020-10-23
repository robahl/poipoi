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
  @IBOutlet weak var needle: UIImageView!
  
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
    
    headingLabel.isHidden = true
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      lastLocation = location
      
      if let trackingPoi = trackingPoi {
        let distance = CLLocation(latitude: trackingPoi.latitude, longitude: trackingPoi.longitude).distance(from: location)
        distanceLabel.text = "Distance: \(Int(round(distance)))"
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    var bearing: CLLocationDirection = 0 // NORTH
    
    if let poi = trackingPoi {
      let destination = CLLocation(latitude: poi.latitude, longitude: poi.longitude)
      bearing = lastLocation?.bearingTo(destination) ?? 0
    }
    
    // For debugging purpose
    //    headingLabel.text = "H: \(magneticHeading) - L: \(round(bearing))  D: \(Float(newHeading.magneticHeading - bearing))"
    
    let angle = bearing - newHeading.magneticHeading;
    needle.transform = CGAffineTransform(rotationAngle: CGFloat(angle.toRadians))
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

