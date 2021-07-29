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

protocol OnboardingRouterDelegate: AnyObject {
    func displayPeopleScreen()
}

class OnboardingRouter: NSObject, OnboardingRoutingLogic, OnboardingDataPassing {
    weak var viewController: OnboardingViewController?
    var dataStore: OnboardingDataStore?
    weak var delegate: OnboardingRouterDelegate?
  
    // MARK: - Routing
    func routeToAccessCamera() {
        navigateToAccessCamera(source: viewController!, destination: GeneralRoute.accessCamera)
    }
    
    func routeToEnablePushNotifications() {
        navigateToEnablePushNotifications(source: viewController!, destination: GeneralRoute.enablePushNotifications)
    }
    
    func routeToEnableLocationsServices() {
        navigateToEnableLocationsServices(source: viewController!, destination: GeneralRoute.enableLocationServices)
    }
    
    // MARK: - Navigation
    
    func navigateToAccessCamera(source: OnboardingViewController, destination: GeneralRoute) {
        guard let accessCameraVC = destination.scene else { return }
        source.navigationController?.pushViewController(accessCameraVC, animated: true)
//        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
    func navigateToEnablePushNotifications(source: OnboardingViewController, destination: GeneralRoute) {
        guard let enablePushNotificationsVC = destination.scene else { return }
        source.navigationController?.pushViewController(enablePushNotificationsVC, animated: true)
//        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
    func navigateToEnableLocationsServices(source: OnboardingViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
}
