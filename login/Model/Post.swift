//
//  Post.swift
//  login
//
//  Created by Floki on 12/4/2023.
//

import Foundation

class Post: ObservableObject, Codable, Identifiable {
    let id: String
    let description: String
    let imageUrl: String?
    let createdDate: String
    let user: Use
    @Published var numberofcomments: Int
    @Published var numberoflickes: Int
    @Published var likes: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description
        case imageUrl
        case createdDate
        case user
        case numberofcomments
        case numberoflickes
        case likes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        createdDate = try container.decode(String.self, forKey: .createdDate)
        user = try container.decode(Use.self, forKey: .user)
        numberofcomments = try container.decode(Int.self, forKey: .numberofcomments)
        numberoflickes = try container.decode(Int.self, forKey: .numberoflickes)
        likes = try container.decode([String].self, forKey: .likes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(user, forKey: .user)
        try container.encode(numberofcomments, forKey: .numberofcomments)
        try container.encode(numberoflickes, forKey: .numberoflickes)
        try container.encode(likes, forKey: .likes)
    }
}
struct PostSingle: Codable, Equatable, Identifiable {
    let id: UUID = UUID()
    let description: String
    let imageUrl: String?
    let createdDate: String
}
//struct PostSingle: Codable, Equatable, Identifiable {
//    let id: UUID
//    let description: String
//    let imageUrl: String?
//    let createdDate: String
//}

struct Use: Codable, Equatable, Identifiable {
    let id: String
    let username: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case image
    }
}

