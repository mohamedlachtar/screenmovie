//
//  Post.swift
//  login
//
//  Created by Floki on 12/4/2023.
//

import Foundation

struct Post: Codable ,Equatable, Identifiable{
    let id: String
    let description: String
    let imageUrl: String
    //let createdDate: String
    let user: String
   
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description
        case imageUrl
        //case createdDate
        case user
       
    }
}

