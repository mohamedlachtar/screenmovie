//
//  Comment.swift
//  login
//
//  Created by Floki on 8/5/2023.
//

import Foundation


struct Comment: Codable, Equatable, Identifiable  {
    let id:     String
    let post: String
    let content: String
    let createdAt: String
    let user: Use
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case post
        case content
        case createdAt
        case user
    }
}
