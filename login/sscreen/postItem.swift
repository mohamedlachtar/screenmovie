//
//  postItem.swift
//  login
//
//  Created by Floki on 25/4/2023.
//

import SwiftUI

struct PostItem: View {

    
  
    @ObservedObject var post: Post
        @ObservedObject var postViewModel: PostViewModel
        @State private var showComments = false
        @State private var newComment = ""
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let imageUrl = post.user.image, !imageUrl.isEmpty {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.circle")
                    }
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                }
                Text(post.user.username)
                    .font(.headline)
            }
            
            Text(post.description)
                .font(.body)
            
            if let postImageUrl = post.imageUrl, !postImageUrl.isEmpty {
                AsyncImage(url: URL(string: postImageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Color(.systemGray5)
                }
                .scaledToFit()
                .cornerRadius(10)
            }
            
            HStack(spacing: 20) {
                           Button(action: {
                               postViewModel.likePost(post: post) { success, error in
                                    if success {
                                        print("Successfully liked/unliked post")
                                    } else if let error = error {
                                        print("Error liking/unliking post: \(error.localizedDescription)")
                                    }
                                }
                           }) {
                               HStack{
                                      Image(systemName: post.likes.contains("643cca9ae78a899f5c152b48") ? "heart.fill" : "heart")
                                          .font(.title2)
                                          .foregroundColor(post.likes.contains("643cca9ae78a899f5c152b48") ? .red : .black)
                                      Text("\(post.numberoflickes)")
                                  }}
                           
                Button(action: {
                    postViewModel.fetchComments(for: post.id)
                    showComments.toggle()
                }) {
                    HStack{
                        Image(systemName: "bubble.right")
                            .font(.title2)
                        Text("\(post.numberofcomments)")
                    }}
                      }
                      .padding(.top)
            if showComments {
                List(postViewModel.comments) { comment in
                    CommentItem(comment: comment)
                }
            }
            
            HStack( spacing: 8) {
            
                    
                 

                 TextField("Add a comment...", text: $newComment)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .padding(.horizontal)

                 Button(action: {
                     postViewModel.addComment(to: post.id, content: newComment)
                     newComment = ""
                 }) {
                     Text("Send")
                 }
                 .padding(.horizontal)
             }
         }
                  .padding()
                  .background(Color(.systemBackground))
                  .cornerRadius(12)
                  .shadow(radius: 5)
        .contextMenu{
                   Button(action: {
                       postViewModel.deletePost(postId: post.id) { result in
                           switch result {
                           case .success(let success):
                               if success {
                                   print("Post deleted")
                                   postViewModel.fetchPosts()
                               } else {
                                   print("Failed to delete post")
                               }
                           case .failure(let error):
                               print("Error deleting post: \(error.localizedDescription)")
                           }
                       }
                   })
                   {
                                   Label("Delete Post", systemImage: "trash")
                               }

               }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let postViewModel = PostViewModel()
       
    }
}



struct CommentItem: View {
    var comment: Comment
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if let imageUrl = comment.user.image, !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.circle")
                }
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(comment.user.username)
                    .font(.headline)
                
                Text(comment.content)
                    .font(.body)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
