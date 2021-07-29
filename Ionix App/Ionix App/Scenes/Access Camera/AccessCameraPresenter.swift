//
//  AccessCameraPresenter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation

protocol AccessCameraPresentationLogic {
    func presentSomething(response: AccessCamera.Something.Response)
}

class AccessCameraPresenter:AccessCameraPresentationLogic {
    weak var viewController: AccessCameraDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: AccessCamera.Something.Response) {
        let viewModel = AccessCamera.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
