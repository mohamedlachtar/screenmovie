//
//  postUser.swift
//  login
//
//  Created by Floki on 6/5/2023.
//


import Foundation
import SwiftUI

struct postUser: View {
    @State private var userPosts: [PostSingle] = []
    
    var body: some View {
        List(userPosts.reversed()) { post in
            VStack(alignment: .leading) {
                Text(post.description)
                    .font(.headline)
                
                if let imageUrl = post.imageUrl,
                   let url = URL(string: imageUrl),
                   let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .onAppear(perform: getUserPost)
    }
    
    func getUserPost() {
        print("test")
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0M2NjYTlhZTc4YTg5OWY1YzE1MmI0OCIsImlhdCI6MTY4MjU5NjQ4MX0.f_SpGXqO0ybcVqpD4mHMKzCnlqe8EJACQly91c1hLKA" // replace with your actual auth token
        guard let url = URL(string: "http://localhost:8080/getPosts/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0M2NjYTlhZTc4YTg5OWY1YzE1MmI0OCIsImlhdCI6MTY4MjU5NjQ4MX0.f_SpGXqO0ybcVqpD4mHMKzCnlqe8EJACQly91c1hLKA") else { return }
        
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
                    let posts = try JSONDecoder().decode([PostSingle].self, from: data)
                    DispatchQueue.main.async {
                        self.userPosts = posts
                    }
                } catch {
                    print("Error decoding new tracks: \(error)")
                }
            }
        }.resume()
    }
}

struct postUserView_Previews: PreviewProvider {
    static var previews: some View {
        postUser()
    }
}
