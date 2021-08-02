//
//  AccessCameraInteractor.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation
import UIKit

protocol AccessCameraBusinessLogic {
    func doSomething(request: AccessCamera.Something.Request)
}

protocol AccessCameraDataStore {
}

class AccessCameraInteractor: AccessCameraBusinessLogic, AccessCameraDataStore {
    var presenter: AccessCameraPresentationLogic?
    var worker: AccessCameraWorker?
  
    // MARK: - Do something
    // Handling the request and will return a response object to the Presenter.
    func doSomething(request: AccessCamera.Something.Request) {
        worker = AccessCameraWorker()
        worker?.doSomeWork()
    
        let response = AccessCamera.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
