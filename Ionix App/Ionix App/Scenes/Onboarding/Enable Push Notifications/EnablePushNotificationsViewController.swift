//
//  EnablePushNotificationsViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit
import UserNotifications

class EnablePushNotificationsViewController: UIViewController {
    
    var router : (NSObjectProtocol & OnboardingRoutingLogic & OnboardingDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.clearBackground()
    }
    
    // MARK: - Methods
    
    func notificationsPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
          if !accepted {
             print("Permisse denied by user")
          }
        }
        router?.routeToEnableLocationsServices()
    }

    // MARK: - Actions
    @IBAction func onClickEnable(_ sender: Any) {
        notificationsPermission()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        router?.routeToEnableLocationsServices()
    }
    
}
