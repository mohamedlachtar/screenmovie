//
//  Home.swift
//  login
//
//  Created by Floki on 13/4/2023.
//

import Foundation


import SwiftUI
struct Home: View {
    
    @StateObject private var vm : PostViewModel
    @State  var usernameError: String = ""
    @State private var showAddPost = false
    let token : String
    
    init(token:String){
        self.token=token
        _vm=StateObject(wrappedValue: PostViewModel(token: token))
    }
    var body: some View {
        TabView{
            HomeScreen().tabItem{
                Image(systemName: "rectangle.portrait.on.rectangle.portrait")
            }
            Text("Search").tabItem{
                Image(systemName: "magnifyingglass")
            }
            CreateNewPost(token: token).environmentObject(vm).tabItem{
                Image(systemName: "plus.square")
            }
            Text("profile").tabItem{
                Image(systemName: "gear")
                
            }.navigationBarBackButtonHidden(true)
            
        }
    }
}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(token: UserDefaults.standard.string(forKey: "token") ?? "")
    }
}
