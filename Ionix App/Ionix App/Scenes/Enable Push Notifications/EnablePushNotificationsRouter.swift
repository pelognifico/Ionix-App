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
    
    func routeToEnableLocationsServices() {
        navigateToEnableLocationsServices(source: viewController!, destination: GeneralRoute.enableLocationServices)
    }
    
    // MARK: - Navigation
    
    func navigateToEnableLocationsServices(source: EnablePushNotificationsViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
}
