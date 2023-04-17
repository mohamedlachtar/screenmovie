//
//  Register.swift
//  login
//
//  Created by Apple Esprit on 16/3/2023.
//



import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var emailError: String = ""
    @State private var usernameError: String = ""
    @State private var passwordError: String = ""
    @State private var isLoading = false
    @State private var loginisactive = false
    @ObservedObject var viewModel = UserViewModel()
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
        VStack {
            Image("zyro")
                .resizable()
                .frame(width: 300, height: 300 , alignment: .center)
            
            
            
            TextField("Email", text: $email)
                .frame(height: 50)
                .foregroundColor(AppColors.primary2)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.7))
                .cornerRadius(30)
                .padding(.horizontal,20)
                
                
            Text(emailError)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .padding(.top, 0)
                .font(Font.system(size: 13))
                .multilineTextAlignment(.leading)

            
            TextField("Username", text: $username)
                .frame(height: 50)
                .foregroundColor(AppColors.primary2)
                .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.7))
                .cornerRadius(30)
                .padding(.horizontal,20)
            
            Text(usernameError)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .padding(.top, 0)
                .font(Font.system(size: 13))
            
            SecureField("Password", text: $password)
                .frame(height: 50)
                .foregroundColor(AppColors.primary2)
                .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.7))
                .cornerRadius(30)
                .padding(.horizontal,20)
            
            Text(passwordError)
                .multilineTextAlignment(.leading)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .padding(.top, 0)
                .font(Font.system(size: 13))
            
            Button(
                action: {
                // Perform sign up action
                withAnimation {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLoading = false
                        if validate() {
                                        signUp()
                                    }
                    }
                }
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint:AppColors.primary2))
                        .scaleEffect(2)
                        .padding()
                } else {
                    Text("Sign Up")
                        .padding(.horizontal,110)
                        .foregroundColor(AppColors.primary)
                        .padding()
                        .background(AppColors.primary2)
                        .cornerRadius(30)
                        .frame(maxWidth: .infinity)
                        
                }
            }
            .padding(.horizontal, 20)
           
            
            
            HStack {
                Text("Have an account ?")
                    .foregroundColor(AppColors.primary2)
                    
                
                Button(action: {isActive = true} ) {
                    Text("Sign In")
                        .foregroundColor(AppColors.primary2)
                        .underline()
                        
                    
                }
                
            }
            
        }
        .padding(.horizontal, 20)
        .disabled(viewModel.isLoading)
        .alert(isPresented: $showError) {
                    Alert(title: Text(errorTitle).foregroundColor(.red), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
        .background(
                    NavigationLink(destination: SignInScreenView().navigationBarHidden(true), isActive: $isActive ) {
                        EmptyView()
                    }
                    .hidden()
                )
                .onReceive(viewModel.$isAuthenticated) { isAuthenticated in
                    isActive = isAuthenticated
                }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(AppColors.primary)}
    }
    
    private func signUp() {
        viewModel.Signup(email: email, password: password, name :username , onSuccess: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        }, onFailure: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        })
    }
    
   

    private func validate() -> Bool {
        var isValid = true
        
        if email.isEmpty {
            emailError = "Email cannot be empty"
        }
        else if   !email.isValidEmail {
            emailError = "Invalid email address"
            isValid = false
        }
        else {
            emailError = ""
        }
        
        if username.isEmpty {
            usernameError = "Username cannot be empty"
            isValid = false
        } else {
            usernameError = ""
        }
        
        if password.isEmpty || password.count < 8 {
            passwordError = "Password must be at least 8 characters"
            isValid = false
        } else {
            passwordError = ""
        }
        
        return isValid
    }

}

           
    
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

