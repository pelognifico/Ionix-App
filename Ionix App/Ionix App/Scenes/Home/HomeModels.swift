//
//  HomeModels.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 27/7/21.
//

import Foundation
import UIKit

enum Home {
  
    // MARK: Use cases
    enum Post {
        struct Request {
            //method get
        }
        
        struct Response: Codable {
            
            let data: ResponseHome
            
            enum CodingKeys: String, CodingKey {
                case data
            }
        }
        
        struct ViewModel {
            let data: ResponseHome
        }
    }
    
    enum SearchPost {
        struct Request {
            let query : String
        }
        
        struct Response: Codable {
            
            let data: ResponseHome
            
            enum CodingKeys: String, CodingKey {
                case data
            }
        }
        
        struct ViewModel {
            let data: ResponseHome
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: HomeError
        }
        struct ViewModel {
            var error: HomeError
        }
    }
}
