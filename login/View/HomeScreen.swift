//import SwiftUI
//import Foundation
//
//
//struct HomeScreen: View {
//    @ObservedObject var postViewModel = PostViewModel()
//    @State private var searchText: String = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                SearchBar(text: $searchText)
//
//                // The fetched posts are being displayed inside this List view.
//                List {
//                    // ForEach loop iterates through the fetched posts.
//                    ForEach(postViewModel.posts.filter { searchText.isEmpty ? true : $0.description.lowercased().contains(searchText.lowercased()) }) { post in
//                        // Each post is displayed using the PostItem view.
//                        PostItem(post: post)
//                    }
//                }
//            }
//            .navigationBarTitle("Home", displayMode: .large)
//        }
//    }
//}
//
//struct SearchBar: UIViewRepresentable {
//    @Binding var text: String
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> UISearchBar {
//        let searchBar = UISearchBar()
//        searchBar.delegate = context.coordinator
//        return searchBar
//    }
//
//    func updateUIView(_ uiView: UISearchBar, context: Context) {
//        uiView.text = text
//    }
//
//    class Coordinator: NSObject, UISearchBarDelegate {
//        var parent: SearchBar
//
//        init(_ parent: SearchBar) {
//            self.parent = parent
//        }
//
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            parent.text = searchText
//        }
//
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.resignFirstResponder()
//        }
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen()
//    }
//}
