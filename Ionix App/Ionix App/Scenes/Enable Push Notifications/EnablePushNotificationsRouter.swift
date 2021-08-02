//
//  EnablePushNotificationsRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 29/7/21.
//

import Foundation

@objc protocol EnablePushNotificationsRoutingLogic {
    func routeToEnableLocationsServices()
}

protocol EnablePushNotificationsDataPassing {
    var dataStore: EnablePushNotificationsDataStore? { get }
}

protocol EnablePushNotificationsRouterDelegate: AnyObject {
    func displayPeopleScreen()
}

class EnablePushNotificationsRouter: NSObject, EnablePushNotificationsRoutingLogic, EnablePushNotificationsDataPassing {
    
    weak var viewController: EnablePushNotificationsViewController?
    var dataStore: EnablePushNotificationsDataStore?
    weak var delegate: EnablePushNotificationsRouterDelegate?
  
    // MARK: - Routing
    // Access to GeneralRoute that contain the routes
    func routeToEnableLocationsServices() {
        navigateToEnableLocationsServices(source: viewController!, destination: GeneralRoute.enableLocationServices)
    }
    
    // MARK: - Navigation
    // Navigate to EnableLocationServicesViewControlller
    func navigateToEnableLocationsServices(source: EnablePushNotificationsViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
}
