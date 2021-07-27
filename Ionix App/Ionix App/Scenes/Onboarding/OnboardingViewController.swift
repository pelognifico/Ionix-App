//
//  OnboardingViewController.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

protocol OnboardingDisplayLogic: AnyObject {
    func displaySomething(viewModel: Onboarding.Something.ViewModel)
}

class OnboardingViewController: UIViewController {
    
    var interactor: OnboardingBusinessLogic?
    var router: (NSObjectProtocol & OnboardingRoutingLogic & OnboardingDataPassing)?

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
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter()
        let router = OnboardingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doSomething()
//        presentPermissions()
        router?.routeToAccessCamera()
        
        self.navigationController?.clearBackground()
    }

    // MARK: - Do something
    func doSomething() {
        let request = Onboarding.Something.Request()
        interactor?.doSomething(request: request)
    }
    
//    func presentPermissions() {
//        let vc = AccessCameraViewController()
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
//    }
}

// MARK: - OnboardingDisplayLogic
extension OnboardingViewController: OnboardingDisplayLogic {
    func displaySomething(viewModel: Onboarding.Something.ViewModel) {
    }
}
