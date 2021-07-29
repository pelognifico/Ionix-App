//
//  HomeInteractor.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import UIKit

protocol HomeBusinessLogic {
    func post(request: Home.Post.Request)
    func searchPost(request: Home.SearchPost.Request)
}

protocol HomeDataStore {
    var post: DataPost? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var post: DataPost?
    
    var worker: HomeServiceProtocol
     
    init(worker: HomeServiceProtocol = HomeWorker()) {
        self.worker = worker
    }
    
    // MARK: - Methods
    func post(request: Home.Post.Request) {
        
        worker.post(request: request, completion: { result in
            switch result {
            case .success(let response):
                
                self.presenter?.presentPost(response: response)
                
            case .failure(let error):
                let response = Home.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
            
        })
    }
    
    func searchPost(request: Home.SearchPost.Request) {
        
        worker.searchPost(request: request, completion: { result in
            switch result {
            case .success(let response):
                
                self.presenter?.presentSearchPost(response: response)
                
            case .failure(let error):
                let response = Home.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
            
        })
    }
}
