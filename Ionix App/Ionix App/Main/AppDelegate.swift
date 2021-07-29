//
//  AppDelegate.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.setRootViewController(UINavigationController(rootViewController: GeneralRoute.accessCamera.scene!), options: .init(direction: .toTop, style: .easeInOut))
        
        return true
    }

}

