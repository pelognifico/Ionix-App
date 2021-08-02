//
//  EnableLocationServicesRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 29/7/21.
//

import Foundation

@objc protocol EnableLocationServicesRoutingLogic {
    func routeToHome()
}

protocol EnableLocationServicesDataPassing {
    var dataStore: EnableLocationServicesDataStore? { get }
}

protocol EnableLocationServicesRouterDelegate: AnyObject {
    func displayPeopleScreen()
}

class EnableLocationServicesRouter: NSObject, EnableLocationServicesRoutingLogic, EnableLocationServicesDataPassing {
    
    weak var viewController: EnableLocationServicesViewController?
    var dataStore: EnableLocationServicesDataStore?
    weak var delegate: EnableLocationServicesRouterDelegate?
  
    // MARK: - Routing
    // Access to GeneralRoute that contain the routes
    func routeToHome() {
        navigateToHome(source: viewController!, destination: GeneralRoute.home)
    }
    
    // MARK: - Navigation
    // Navigate to HomesViewControlller
    func navigateToHome(source: EnableLocationServicesViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
}
