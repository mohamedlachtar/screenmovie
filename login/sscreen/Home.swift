////
////  Home.swift
////  login
////
////  Created by Floki on 13/4/2023.
////
//
import Foundation


import SwiftUI
import SwiftUI

//struct Home: View {
//
//    @StateObject private var postViewModel: PostViewModel = PostViewModel()
//    @State private var usernameError: String = ""
//    @State private var showAddPost = false
//    let token: String
//
//    init(token: String) {
//        self.token = token
//    }
//
//    var body: some View {
//        VStack { // Wrapping TabView inside a VStack
//            TabView {
//                HomeScreen()
//                    .tabItem {
//                        Image(systemName: "rectangle.portrait.on.rectangle.portrait")
//                    }
//
//                CreateNewPost()
//                    .environmentObject(postViewModel)
//                    .tabItem {
//                        Image(systemName: "plus.square")
//                    }
//
//                ProfileView()
//                    .environmentObject(postViewModel)
//                    .tabItem {
//                        Image(systemName: "person")
//                    }
//                    .navigationBarBackButtonHidden(true)
//            }
//            .accentColor(AppColors.primary2) // Adding accent color to TabView
//        }
//        .padding(5) // Adding padding to the VStack
//        .border(AppColors.primary, width: 2) // Applying a border to the VStack
//    }
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(token: UserDefaults.standard.string(forKey: "token") ?? "")
//    }
//}
struct Home: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var postViewModel: PostViewModel = PostViewModel()
    @State private var usernameError: String = ""
    @State private var showAddPost = false
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    var accentColor: Color {
        colorScheme == .dark ? Color.yellow : AppColors.primary2
    }
    
    var borderColor: Color {
        colorScheme == .dark ? Color.white : AppColors.primary
    }
    
    var body: some View {
        VStack {
            TabView {
                HomeScreen()
                    .tabItem {
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait")
                    }
                
                CreateNewPost()
                    .environmentObject(postViewModel)
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                ProfileView()
                    .environmentObject(postViewModel)
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .navigationBarBackButtonHidden(true)
            }
            .accentColor(accentColor)
        }
        .padding(5)
        .border(borderColor, width: 2)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(token: UserDefaults.standard.string(forKey: "token") ?? "")
    }
}
