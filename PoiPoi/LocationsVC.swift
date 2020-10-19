//
//  LocationsVC.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-15.
//

import UIKit

class LocationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  let mock = ["hej", "min", "lilla", "kompis", "vad", "gor", "du", "i dag", "tihi"]
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return State.shared.poiLocations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") {
      let location = State.shared.poiLocations[indexPath.row]
      cell.textLabel?.text = location.name
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    State.shared.trackingPoi = State.shared.poiLocations[indexPath.row]
    // Navigate to DirectionsVC
    tabBarController?.selectedIndex = 1
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
}
