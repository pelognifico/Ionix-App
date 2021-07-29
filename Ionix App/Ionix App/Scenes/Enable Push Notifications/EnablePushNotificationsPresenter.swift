//
//  EnablePushNotificationsPresenter.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 29/7/21.
//

import Foundation

protocol EnablePushNotificationsPresentationLogic {
    func presentSomething(response: EnablePushNotifications.Something.Response)
}

class EnablePushNotificationsPresenter: EnablePushNotificationsPresentationLogic {
    weak var viewController: EnablePushNotificationsDisplayLogic?
  
    // MARK: - Do something
    func presentSomething(response: EnablePushNotifications.Something.Response) {
        let viewModel = EnablePushNotifications.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
