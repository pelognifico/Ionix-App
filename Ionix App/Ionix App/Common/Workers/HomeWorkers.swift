//
//  HomeWorkers.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 28/7/21.
//

import Foundation

protocol HomeServiceProtocol {
    func post(request: Home.Post.Request, completion: @escaping (Result<Home.Post.Response, HomeError>) -> Void)
    func searchPost(request: Home.SearchPost.Request, completion: @escaping (Result<Home.SearchPost.Response, HomeError>) -> Void)
}

class HomeWorker: HomeServiceProtocol{
    var homeService: HomeServiceProtocol
    
    init(homeService: HomeServiceProtocol = HomeAPI()) {
        self.homeService = homeService
    }
    
    func post(request: Home.Post.Request, completion: @escaping (Result<Home.Post.Response, HomeError>) -> Void) {
        homeService.post(request: request, completion: { result in
            completion(result)
        })
    }
    
    func searchPost(request: Home.SearchPost.Request, completion: @escaping (Result<Home.SearchPost.Response, HomeError>) -> Void) {
        homeService.searchPost(request: request, completion: { result in
            completion(result)
        })
    }
    
}
