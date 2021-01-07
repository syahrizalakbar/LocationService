//
//  ViewController.swift
//  Location Service
//
//  Created by IDOUDA on 07/01/21.
//  Copyright © 2021 IDOUDA. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var stop: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    
    let location = CLLocationManager()
    let firebase: DatabaseReference = Database.database().reference(withPath: "LocationService")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Sayang sekali View")
    }
    
    @IBAction func startClicked(_ sender: Any) {
        print("Start")
        label1.text = "Start"
        location.startUpdatingLocation()
    }
    
    @IBAction func stopClicked(_ sender: Any) {
        print("Stop")
        label1.text = "Stop"
        location.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let last = locations.last else {
            print("No Location")
            return
        }
        
        let newLoc = "Lat:\(last.coordinate.latitude), Lon:\(last.coordinate.longitude)"
        label1.text = newLoc
        print(newLoc)
        
        firebase.child("location").setValue([
            "latitude": last.coordinate.latitude,
            "longitude": last.coordinate.longitude
        ])
    }
    
}

