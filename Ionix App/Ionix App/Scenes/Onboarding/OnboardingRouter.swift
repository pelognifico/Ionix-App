//
//  OnboardingRouter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

@objc protocol OnboardingRoutingLogic {
}

protocol OnboardingDataPassing {
    var dataStore: OnboardingDataStore? { get }
}

class OnboardingRouter: NSObject, OnboardingRoutingLogic, OnboardingDataPassing {
    weak var viewController: OnboardingViewController?
    var dataStore: OnboardingDataStore?
  
}
