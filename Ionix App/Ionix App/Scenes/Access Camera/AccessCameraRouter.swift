//
//  AccessCameraRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation

@objc protocol AccessCameraRoutingLogic {
    func routeToEnablePushNotifications()
}

protocol AccessCameraDataPassing {
    var dataStore: AccessCameraDataStore? { get }
}

protocol AccessCameraRouterDelegate: AnyObject {
    func displayPeopleScreen()
}

class AccessCameraRouter: NSObject, AccessCameraRoutingLogic, AccessCameraDataPassing {
    
    weak var viewController: AccessCameraViewController?
    var dataStore: AccessCameraDataStore?
    weak var delegate: AccessCameraRouterDelegate?
  
    // MARK: - Routing
    // Access to GeneralRoute that contain the routes
    func routeToEnablePushNotifications() {
        navigateToEnablePushNotifications(source: viewController!, destination: GeneralRoute.enablePushNotifications)
    }
    
    // MARK: - Navigation
    // Navigate to EnablePushNotificationsViewControlller
    func navigateToEnablePushNotifications(source: AccessCameraViewController, destination: GeneralRoute) {
        guard let enablePushNotificationsVC = destination.scene else { return }
        source.navigationController?.pushViewController(enablePushNotificationsVC, animated: true)
    }
}
