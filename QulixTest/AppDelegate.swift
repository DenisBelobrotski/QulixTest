//
//  AppDelegate.swift
//  QulixTest
//
//  Created by Denis Belobrotski on 31.01.2018.
//  Copyright © 2018 Denis Belobrotski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    
    
    // MARK: - Internal methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let trendingsViewController = TrendingsViewController()
        let navigationController = UINavigationController(rootViewController: trendingsViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

