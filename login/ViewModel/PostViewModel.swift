//
//  PostsViewModel.swift
//  login
//
//  Created by Floki on 12/4/2023.
//

import Combine
import UIKit
import Alamofire
import Foundation
import  Alamofire
import Combine
import CoreData
import SwiftUI

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String?
    @Published var userPosts: [Post] = []
    @Published var comments: [Comment] = []
    
    
    
    init() {
        fetchPosts()
        // fetchPostsbyId()
    }
    
    func fetchPosts() {
        AF.request("http://localhost:8080/posts", method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                // print raw data as a string
                print(String(data: data, encoding: .utf8) ?? "Could not print data as string")
                
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                } catch {
                    print("Error decoding posts: \(error)")
                }
            case .failure(let error):
                print("Error fetching posts: \(error)")
            }
        }
    }
    func fetchComments(for postId: String) {
        AF.request("http://localhost:8080/api/Comments/\(postId)", method: .get).validate().responseDecodable(of: [Comment].self) { response in
            switch response.result {
            case .success(let comments):
                DispatchQueue.main.async {
                    print(comments)
                    self.comments = comments
                }
            case .failure(let error):
                print("Error decoding comments: \(error)")
            }
        }
    }
    func addPost( description: String, imageUrl: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let parameters: [String: Any] = [
            "description": description,
            "token":token
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if let stringValue = value as? String {
                    if let data = stringValue.data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            }
            
            if let imageData = imageUrl.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "imageUrl", fileName: "Post.jpg", mimeType: "image/jpeg")
            }
        }, to: "http://localhost:8080/createPost")
        .responseJSON { response in
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    func getUserPost() {
        let token = "your-auth-token" // replace with your actual auth token
        guard let url = URL(string: "http://localhost:8080/getPosts") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set authorization header
        let headers = ["Authorization": "Bearer \(token)"]
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.userPosts = posts
                        print(self.userPosts)
                    }
                } catch {
                    print("Error decoding new posts: \(error)")
                }
            }
        }.resume()}
        
        func deletePost(postId : String ,completion: @escaping (Result<Bool, Error>) -> Void) {
            
            let url = URL(string: "http://localhost:8080/deletePost")!
            
            let parameters: [String: Any] = [
                
                "postId" : postId
                
            ]
            AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            
                .responseJSON { response in
                    
                    switch response.result {
                        
                    case .success:
                        
                        completion(.success(true))
                        
                    case .failure(let error):
                        
                        completion(.failure(error))
                        
                    }
                    
                }
        }
    
    func addComment(to postId: String, content: String) {
        let parameters: [String: Any] = ["post": postId, "content": content,"user":"643cca9ae78a899f5c152b48"]
        
        AF.request("http://localhost:8080/api/comment", method: .post, parameters: parameters,encoding: JSONEncoding.default)  .responseJSON { response in
            print("Response: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "")")
            print("Post ID: \(postId)")
            switch response.result {
               
            case .success:
                print("Comment added successfully")
            case .failure(let error):
                print("Error adding comment: \(error)")
            }
        }
    }
    
    struct LikeParameters: Encodable {
        let post: String
        let user: String
    }

    func likePost(post: Post, completion: @escaping (Bool, Error?) -> Void) {
        let userId = "643cca9ae78a899f5c152b48"
        let parameters = LikeParameters(post: post.id, user: userId)
            
        AF.request("http://localhost:8080/api/like",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default)
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                if let jsonDict = json as? [String: Any],
                   let numberoflickes = jsonDict["numberoflickes"] as? Int,
                   let likes = jsonDict["likes"] as? [String] {
                    DispatchQueue.main.async {
                        post.numberoflickes = numberoflickes
                        post.likes = likes
                    }
                    completion(true, nil)
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }

        
    }
