//
//  GeneralRoute.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case onboarding
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .onboarding:
            return OnboardingViewController()
        }
    }
}
