//
//  MapVC.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-24.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  @IBOutlet weak var mapView: MKMapView!
  
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastLocation = locations.last {
      let coordinate = lastLocation.coordinate
      let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
      mapView.setCenter(coordinate, animated: true)
      mapView.setRegion(viewRegion, animated: true)
    }
  }
  
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    print("ok")
  }
  
  
}
