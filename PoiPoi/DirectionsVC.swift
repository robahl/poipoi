//
//  ViewController.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-10.
//

import UIKit
import CoreLocation

class DirectionsVC: UIViewController, CLLocationManagerDelegate {
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var compassView: CompassView!
  
  var locationManager = CLLocationManager()
  var lastLocation: CLLocation?
  
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
      latitudeLabel.text = "Lat: \(location.coordinate.latitude)"
      longitudeLabel.text = "Lon: \(location.coordinate.longitude)"
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    headingLabel.text = "Heading \(newHeading.magneticHeading)"
    
    compassView.needleAngle = newHeading.magneticHeading
    
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
        
        State.shared.poiLocations.append(PoiLocation(name: textField?.text ?? "Untitled", location: location))
        // Navigate to the locations table view
        self.tabBarController?.selectedIndex = 0
      }))
      
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

