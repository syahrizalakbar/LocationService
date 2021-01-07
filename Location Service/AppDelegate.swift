//
//  AppDelegate.swift
//  Location Service
//
//  Created by IDOUDA on 07/01/21.
//  Copyright © 2021 IDOUDA. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    
    let location = CLLocationManager()
    var firebase: DatabaseReference?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        firebase = Database.database().reference(withPath: "LocationServiceFromKilled")
        location.delegate = self
        location.requestAlwaysAuthorization()
        location.allowsBackgroundLocationUpdates = true
        location.startMonitoringSignificantLocationChanges()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        firebase?.child("KESINI").setValue([
            "latitude": locations.last?.coordinate.latitude ?? 0.0,
            "longitude": locations.last?.coordinate.longitude ?? 0.0,
        ])
        print("Dapet significant new tapi foreground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Sayang sekali Terminate")
    }


}

