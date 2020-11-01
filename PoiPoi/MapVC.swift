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
  var initialMapPosition: CLLocationCoordinate2D? {
    didSet {
      mapCenterArea(coordinate: initialMapPosition!)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    
    mapView.showsUserLocation = true
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastLocation = locations.last {
      
      // Only set once
      if initialMapPosition == nil {
        initialMapPosition = lastLocation.coordinate
      }
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }
    
    let identifier = "Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
    } else {
      annotationView?.annotation = annotation
    }
    
    return annotationView
  }
  
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    print("ok")
    
    // Populate annotations
    for location in State.shared.poiLocations {
      let annotation = MKPointAnnotation()
      annotation.title = location.name
      annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
      mapView.addAnnotation(annotation)
    }
  }
  
  private func mapCenterArea(coordinate: CLLocationCoordinate2D) {
    let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    mapView.setCenter(coordinate, animated: false)
    mapView.setRegion(viewRegion, animated: true)
  }
  
  
}
