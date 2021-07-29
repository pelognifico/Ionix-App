//
//  EnableLocationServicesPresenter.swift
//  Ionix App
//
//  Created by Ruben Duarte on 29/7/21.
//

import Foundation

protocol EnableLocationServicesPresentationLogic {
    func presentSomething(response: EnableLocationServices.Something.Response)
}

class EnableLocationServicesPresenter: EnableLocationServicesPresentationLogic {
    weak var viewController: EnableLocationServicesDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: EnableLocationServices.Something.Response) {
        let viewModel = EnableLocationServices.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
