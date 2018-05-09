//
//  AppDelegate.swift
//  RxUnsplashExample
//
//  Created by Kauna Mohammed on 08/05/2018.
//  Copyright © 2018 NytCompany. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = LogInViewController()
     //   let _ = UINavigationController(rootViewController: viewController)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }


}

