//
//  EnableLocationServicesRouter.swift
//  Ionix App
//
//  Created by Ruben Duarte on 29/7/21.
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
    
    func routeToHome() {
        navigateToHome(source: viewController!, destination: GeneralRoute.home)
    }
    
    // MARK: - Navigation
    
    func navigateToHome(source: EnableLocationServicesViewController, destination: GeneralRoute) {
        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
    
}
