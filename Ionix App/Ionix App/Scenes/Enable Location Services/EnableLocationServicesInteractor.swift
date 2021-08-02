//
//  EnableLocationServicesInteractor.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 29/7/21.
//

import Foundation

protocol EnableLocationServicesBusinessLogic {
    func doSomething(request: EnableLocationServices.Something.Request)
}

protocol EnableLocationServicesDataStore {
}

class EnableLocationServicesInteractor: EnableLocationServicesBusinessLogic, EnableLocationServicesDataStore {
    
    var presenter: EnableLocationServicesPresentationLogic?
    var worker: EnableLocationServicesWorker?
  
    // MARK: - Do something
    // Handling the request and will return a response object to the Presenter.
    func doSomething(request: EnableLocationServices.Something.Request) {
        worker = EnableLocationServicesWorker()
        worker?.doSomeWork()
    
        let response = EnableLocationServices.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
