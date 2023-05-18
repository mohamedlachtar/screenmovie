//
//  newpassword.swift
//  login
//
//  Created by Floki on 6/5/2023.
//

import SwiftUI

struct newpassword: View {
    

@ObservedObject var viewModel = UserViewModel()
        @State  var username = ""
        @State var newpassword = ""
        @State  var password = ""
        @State private var showError = false
        @State private var errorTitle = ""
        @State private var errorMessage = ""
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("New Password").font(.title)
                
                TextField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter new password", text: $newpassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
               
                
                Button(action: {viewModel.updatePassword(newpassword: newpassword, password: password, token: UserDefaults.standard.string(forKey: "token")!    ,  onSuccess: { title, message in
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
                    Text("Save password")
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
           
        }
    }





struct newpassword_Previews: PreviewProvider {
    static var previews: some View {
        newpassword()
    }
}
