//
//  File.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI

struct SignInScreenView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if vm.authenticated {
            // Show the view you want users to see when logged on
            VStack(spacing: 20) {
                Text("Welcome back **\(vm.username.lowercased())**!")
                Text("Today is: **\(Date().formatted(.dateTime))**")
                Button("Log out", action: vm.logOut)
                    .background(
                    Capsule())
            }
        } else {
            // Show a login screen
            ZStack {
                Image("sky")
                   
              
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    Text("Log in")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .medium, design: .rounded))
                        .underline()

                    TextField("Username", text: $vm.username)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                    SecureField("Password", text: $vm.password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                    Button("Forgot password?", action: vm.logPressed)
                        .tint(.red.opacity(0.80))
                    HStack {
                        Spacer()
                     
                        Spacer()
                        Button("Login",role: .cancel, action: vm.authenticate)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            .padding(.vertical)
                        Spacer()
                    }
                    
             
                    
                    
                    Spacer()
                }
                .alert("Your username or password is incorrect", isPresented: $vm.invalid) {
                    Button("Ok", action: vm.logPressed)
                }
                .frame(width: 300)
                .padding()
            }
            .transition(.offset(x: 0, y: 850))
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

