//
//  OnboardingPresenter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

protocol OnboardingPresentationLogic {
    func presentSomething(response: Onboarding.Something.Response)
}

class OnboardingPresenter: OnboardingPresentationLogic {
    weak var viewController: OnboardingDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: Onboarding.Something.Response) {
        let viewModel = Onboarding.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
