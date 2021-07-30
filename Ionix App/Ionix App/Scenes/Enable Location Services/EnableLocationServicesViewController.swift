//
//  EnableLocationServicesViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit
import CoreLocation

protocol EnableLocationServicesDisplayLogic: AnyObject {
    func displaySomething(viewModel: EnableLocationServices.Something.ViewModel)
}

class EnableLocationServicesViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var interactor: EnableLocationServicesBusinessLogic?
    var router: (NSObjectProtocol & EnableLocationServicesRoutingLogic & EnableLocationServicesDataPassing)?

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
        let interactor = EnableLocationServicesInteractor()
        let presenter = EnableLocationServicesPresenter()
        let router = EnableLocationServicesRouter()
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
    
    func getLocation() {
        let status = CLLocationManager.authorizationStatus()

            switch status {
                // 1
            case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    return

                // 2
            case .denied, .restricted:
                let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)

                present(alert, animated: true, completion: nil)
                return
                
                // 3
            case .authorizedAlways, .authorizedWhenInUse:
                break

            }

            // 4
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        
        router?.routeToHome()
    }
    
    // MARK: - Do something
    func doSomething() {
        let request = EnableLocationServices.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    // MARK: - Actions
    
    @IBAction func onClickEnable(_ sender: Any) {
        getLocation()
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        router?.routeToHome()
    }
    
}

extension EnableLocationServicesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
                print("Current location: \(currentLocation)")
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - EnableLocationServicesDisplayLogic
extension EnableLocationServicesViewController: EnableLocationServicesDisplayLogic {
    func displaySomething(viewModel: EnableLocationServices.Something.ViewModel) {
    }
}
