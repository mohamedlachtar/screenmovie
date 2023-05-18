//
//  newusername.swift
//  login
//
//  Created by Floki on 6/5/2023.
//

import SwiftUI

struct newusername: View {
    

@ObservedObject var viewModel = UserViewModel()
        @State  var username = ""
    
        @State private var showError = false
        @State private var errorTitle = ""
        @State private var errorMessage = ""
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("New Username").font(.title)
                
                TextField("Enter new username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
              
               
                
                Button(action: {viewModel.updateUsername(username: username,token: UserDefaults.standard.string(forKey: "token")!    ,  onSuccess: { title, message in
                    errorTitle = title
                                errorMessage = message
                                showError = true
                   
                }, onFailure: { title, message in
                    errorTitle = title
                                errorMessage = message
                                showError = true
                   
                })

                })
                       {
                    Text("Save Username")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .alert(isPresented: $showError) {
            Alert(title: Text(errorTitle).foregroundColor(.red), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
           
        }}

struct newusername_Previews: PreviewProvider {
    static var previews: some View {
        newusername()
    }
}
