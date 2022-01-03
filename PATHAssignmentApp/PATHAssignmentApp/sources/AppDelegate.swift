//
//  AppDelegate.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import UIKit
import MarvelAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        CoreDataManager.shared.start()
        
        MarvelAPI.shared.setUp(
            publicKey: "",
            privateKey: "",
            pageLimit: 30
        )
        
        window?.rootViewController = TabBarController()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }
}
