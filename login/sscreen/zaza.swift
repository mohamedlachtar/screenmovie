import SwiftUI

struct Postt: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var imageName: String
    var likes: Int
    var comments: Int
}

struct zaza: View {
    var posts: [Postt] = [
        Postt(title: "My First Post", body: "Hello world!", imageName: "post1", likes: 12, comments: 4),
        Postt(title: "My Second Post", body: "This is my second post.", imageName: "post2", likes: 8, comments: 2),
        Postt(title: "My Third Post", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", imageName: "post3", likes: 20, comments: 5),
    ]
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                NavigationLink(destination: PostDetaill(post: post)) {
                    VStack(alignment: .leading, spacing: 10) {
                        Image("1145988")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("\(post.likes)")
                            
                            Image(systemName: "bubble.right.fill")
                            Text("\(post.comments)")
                        }
                        
                        Text(post.title)
                            .font(.headline)
                        
                        Text(post.body)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("My Blog")
        }
    }
}

struct PostDetaill: View {
    var post: Postt
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image("1145988")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                Text("\(post.likes)")
                
                Image(systemName: "bubble.right.fill")
                Text("\(post.comments)")
            }
            
            Text(post.title)
                .font(.headline)
            
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle(post.title)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        zaza()
    }
}
