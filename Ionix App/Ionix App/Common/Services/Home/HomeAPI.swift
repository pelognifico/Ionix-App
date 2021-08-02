//
//  HomeAPI.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 28/7/21.
//

import Foundation

class HomeAPI: HomeServiceProtocol {
    
    // Comunication with EndPoint
    func post(request: Home.Post.Request, completion: @escaping (Result<Home.Post.Response, HomeError>) -> Void) {
        NetworkService.share.request(endpoint: HomeEndpoint.getPost) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(Home.Post.Response.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
    
    // Comunication with EndPoint
    func searchPost(request: Home.SearchPost.Request, completion: @escaping (Result<Home.SearchPost.Response, HomeError>) -> Void) {
        
        NetworkService.share.request(endpoint: HomeEndpoint.searchPost(parameter: request.query)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(Home.SearchPost.Response.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
