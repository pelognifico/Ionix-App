//
//  EnablePushNotificationsInteractor.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 29/7/21.
//

import Foundation
import UIKit

protocol EnablePushNotificationsBusinessLogic {
    func doSomething(request: EnablePushNotifications.Something.Request)
}

protocol EnablePushNotificationsDataStore {
}

class EnablePushNotificationsInteractor: EnablePushNotificationsBusinessLogic, EnablePushNotificationsDataStore {
    var presenter: EnablePushNotificationsPresentationLogic?
    var worker: EnablePushNotificationsWorker?
  
    // MARK: Do something
    func doSomething(request: EnablePushNotifications.Something.Request) {
        worker = EnablePushNotificationsWorker()
        worker?.doSomeWork()
    
        let response = EnablePushNotifications.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
