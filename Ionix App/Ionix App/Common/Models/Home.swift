//
//  Home.swift
//  Ionix App
//
//  Created by Carlos Villamizar on 28/7/21.
//

import Foundation

// MARK: - Response Home
struct ResponseHome: Codable {
    let children: [Children]
}

// MARK: - Foundation
struct Children : Codable {
    let kind : String
    let data : DataPost
}

struct DataPost : Codable {
    let link_flair_text: String?
    let post_hint: String?
    let title: String
    let url: String
    let score: Int
    let num_comments: Int
}
