//
//  EnableLocationServicesInteractor.swift
//  Ionix App
//
//  Created by Ruben Duarte on 29/7/21.
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
  
    // MARK: Do something
    func doSomething(request: EnableLocationServices.Something.Request) {
        worker = EnableLocationServicesWorker()
        worker?.doSomeWork()
    
        let response = EnableLocationServices.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
