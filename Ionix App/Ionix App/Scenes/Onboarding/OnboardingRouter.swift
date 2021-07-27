//
//  OnboardingRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit
import Foundation

@objc protocol OnboardingRoutingLogic {
    func routeToAccessCamera()
    func routeToEnablePushNotifications()
    func routeToEnableLocationsServices()
}

protocol OnboardingDataPassing {
    var dataStore: OnboardingDataStore? { get }
}

class OnboardingRouter: NSObject, OnboardingRoutingLogic, OnboardingDataPassing {
    weak var viewController: OnboardingViewController?
    var dataStore: OnboardingDataStore?
  
    // MARK: - Routing
    func routeToAccessCamera() {
        navigateToAccessCamera(source: viewController!, destination: .accessCamera)
    }
    
    func routeToEnablePushNotifications() {
        navigateToEnablePushNotifications(source: viewController!, destination: .enablePushNotifications)
    }
    
    func routeToEnableLocationsServices() {
        navigateToEnableLocationsServices(source: viewController!, destination: .enableLocationServices)
    }
    
    // MARK: - Navigation
    
    func navigateToAccessCamera(source: OnboardingViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
    func navigateToEnablePushNotifications(source: OnboardingViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
    func navigateToEnableLocationsServices(source: OnboardingViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
}
