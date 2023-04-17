//
//  PostCell.swift
//  login
//
//  Created by Floki on 11/4/2023.
//

import Foundation

/*struct Post: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
    var likes: Int = 0
    var comments: Int = 0
}*/

/*struct PostCell: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(post.image)
                .resizable()
                .scaledToFit()
            
            Text(post.title)
                .font(.headline)
            
            Text(post.description)
                .font(.body)
            
            HStack {
                Image(systemName: "heart")
                Text("\(post.likes)")
                
                Image(systemName: "message")
                Text("\(post.comments)")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ContentView: View {
    let posts = [        Post(image: "post1", title: "Post 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),        Post(image: "post2", title: "Post 2", description: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),        Post(image: "post3", title: "Post 3", description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")    ]
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                PostCell(post: post)
            }
            .navigationBarTitle("Posts")
        }
    }
}
struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}*/

