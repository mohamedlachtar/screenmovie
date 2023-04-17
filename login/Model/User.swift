//
//  User.swift
//  login
//
//  Created by Floki on 31/3/2023.
//

struct User: Codable {
    let email: String
    let token: String
    let name : String
    let image : String

    
    private enum CodingKeys: String, CodingKey {
        case email
        case token
        case name
        case image
    }
}

