//
//  HomeEndPoint.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 28/7/21.
//

import Foundation
import Alamofire

enum HomeEndpoint {
    case getPost
    case searchPost(parameter: String)
}

extension HomeEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getPost, .searchPost:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPost:
            return ".json?limit=100"
        case .searchPost(let parameter):
            return "search.json?q=\(parameter)&limit=100"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getPost, .searchPost:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getPost, .searchPost:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
