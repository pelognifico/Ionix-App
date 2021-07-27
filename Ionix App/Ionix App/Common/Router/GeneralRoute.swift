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
    case accessCamera
    case enablePushNotifications
    case enableLocationServices
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .onboarding:
            return OnboardingViewController()
        case .accessCamera:
            return AccessCameraViewController()
        case .enablePushNotifications:
            return EnablePushNotificationsViewController()
        case .enableLocationServices:
            return EnableLocationServicesViewController()
        }
    }
}
