//
//  HomeRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation

@objc protocol HomeRoutingLogic {
    func routeToAccessCamera()
}

protocol HomeDataPassing {
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: - Routing
    func routeToAccessCamera() {
        navigateToAccessCamera(source: viewController!, destination: GeneralRoute.accessCamera)
    }
    
    // MARK: - Navigation
    
    func navigateToAccessCamera(source: HomeViewController, destination: GeneralRoute) {
        guard let accessCameraVC = destination.scene else { return }
        source.navigationController?.pushViewController(accessCameraVC, animated: true)
//        source.navigationController?.pushViewController(destination.scene!, animated: true)
    }
}
