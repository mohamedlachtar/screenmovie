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
//import  Alamofire
//import Combine
//import CoreData
//import SwiftUI
//
//
//class PostsViewModel : ObservableObject {
//    @Published var posts: [Post] = []
//    @Published var errorMessage = ""
//    var userId:String = ""
//
//    func fetchPosts() {
//        guard let url = URL(string: "http://localhost:8080/getPosts") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body = ["userId": userId]
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
//        request.httpBody = httpBody
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            if let posts = try? decoder.decode([Post].self, from: data) {
//                DispatchQueue.main.async {
//                    self.posts = posts // Update self.posts here
//                }
//            }
//        }.resume()
//    }
//    func fetchPosts(for userId: String) {
//           guard let url = URL(string: "http://localhost:8080/getPosts") else {
//               fatalError("Invalid URL")
//           }
//
//           let parameters = ["userId": String(userId)]
//           var request = URLRequest(url: url)
//           request.httpMethod = "POST"
//           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//           request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//
//           let session = URLSession.shared
//           let task = session.dataTask(with: request) { data, response, error in
//               guard let data = data else {
//                   fatalError("No data in response: \(error?.localizedDescription ?? "Unknown error")")
//               }
//
//               print(String(data: data, encoding: .utf8) ?? "Unable to decode data")
//
//               do {
//                   let decoder = JSONDecoder()
//                   let postsData = try decoder.decode([Post].self, from: data)
//                   print(postsData)
//                   DispatchQueue.main.async {
//                       self.posts = postsData
//
//                   }
//               } catch {
//                   fatalError("Error decoding response: \(error.localizedDescription)")
//               }
//           }
//           task.resume()
//       }
//
//
//}
class PostViewModel : ObservableObject {
    @Published var createdPost: Post?
    
    let token : String
    
    init(token:String = UserDefaults.standard.string(forKey: "token") ?? ""){
        self.token=token
    }
        
    /*func createPost(description: String, image: UIImage, token: String) {
            // Create the URL request
            let url = URL(string: "http://localhost:8080/createPost")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            // Create the post data to be sent in the request body
            let boundary = UUID().uuidString
            let contentType = "multipart/form-data; boundary=\(boundary)"
            let imageData = image.jpegData(compressionQuality: 0.5)!
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(description)\r\n".data(using: .utf8)!)
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"createdDate\"\r\n\r\n".data(using: .utf8)!)
            //body.append("\(createdDate)\r\n".data(using: .utf8)!)
            //body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpeg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            // Set the request body and content type
            request.httpBody = body
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            // Send the API request
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let post = try decoder.decode(Post.self, from: data)
                    DispatchQueue.main.async {
                        self.createdPost = post
                    }
                } catch {
                    print("Error decoding post: \(error.localizedDescription)")
                }
            }.resume()
        }*/
    
    @Published var posts = [Post]()
        
        func createPost(description: String, image: UIImage, token: String, completion: @escaping (Result<Post, Error>) -> Void) {
            
            let headers: HTTPHeaders = [
                       "Authorization": "Bearer \(token)"
                   ]
            
            let parameters: [String: Any] = [
                "description":description
            ]
            
            
//            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//                completion(.failure(NSError(domain: "localhost", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
//                return
//            }
//
//            AF.upload(multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
//                multipartFormData.append(description.data(using: .utf8)!, withName: "description")
//            }, to: "http://localhost:8080/createPost", headers: headers)
//            .responseDecodable(of: Post.self) { response in
//                switch response.result {
//                case .success(let post):
//                    completion(.success(post))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
            
            AF.upload(multipartFormData:{multipartFormData in
                for(key, value) in parameters{
                    if let stringValue = value as? String {
                        if let data = stringValue.data(using: .utf8){
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
                
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: "imageUrl", fileName: "baby.jpg", mimeType: "image/jpeg")
                }}, to: "http://localhost:8080/createPost", headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(.success(self.createdPost ?? Post(id: "", description: "", imageUrl: "", user: "")))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }


}
