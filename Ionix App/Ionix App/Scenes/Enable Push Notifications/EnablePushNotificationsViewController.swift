//
//  EnablePushNotificationsViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit
import UserNotifications

protocol EnablePushNotificationsDisplayLogic: AnyObject {
    func displaySomething(viewModel: EnablePushNotifications.Something.ViewModel)
}

class EnablePushNotificationsViewController: UIViewController {
    
    var interactor: EnablePushNotificationsBusinessLogic?
    var router: (NSObjectProtocol & EnablePushNotificationsRoutingLogic & EnablePushNotificationsDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = EnablePushNotificationsInteractor()
        let presenter = EnablePushNotificationsPresenter()
        let router = EnablePushNotificationsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.clearBackground()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: - Methods
    
    // Request the permission to enable notifications push
    func notificationsPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if granted {
                    print("Notifications permission granted.")
                    DispatchQueue.main.async {
                        self.router?.routeToEnableLocationsServices()
                    }
                }
                else {
                    print("Notifications permission denied because: \(error?.localizedDescription).")
                }
        }
    }
    
    // MARK: - Do something
    // Request service something
    func doSomething() {
        let request = EnablePushNotifications.Something.Request()
        interactor?.doSomething(request: request)
    }

    // MARK: - Actions
    @IBAction func onClickEnable(_ sender: Any) {
        notificationsPermission()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        router?.routeToEnableLocationsServices()
    }
    
}

// MARK: - EnablePushNotificationsDisplayLogic
extension EnablePushNotificationsViewController: EnablePushNotificationsDisplayLogic {
    func displaySomething(viewModel: EnablePushNotifications.Something.ViewModel) {
    }
}
