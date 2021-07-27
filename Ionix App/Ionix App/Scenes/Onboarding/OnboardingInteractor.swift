//
//  OnboardingInteractor.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

protocol OnboardingBusinessLogic {
    func doSomething(request: Onboarding.Something.Request)
}

protocol OnboardingDataStore {
}

class OnboardingInteractor: OnboardingBusinessLogic, OnboardingDataStore {
    var presenter: OnboardingPresentationLogic?
    var worker: OnboardingWorker?
  
    // MARK: Do something
    func doSomething(request: Onboarding.Something.Request) {
        worker = OnboardingWorker()
        worker?.doSomeWork()
    
        let response = Onboarding.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
