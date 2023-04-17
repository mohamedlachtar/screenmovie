//
//  File.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI

struct SignInScreenView: View {
    @State private var isActive = false
    @State private var isSignupActive = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var isLoading = false
    @State private var rememberMe = false
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isReset1Active = false
    @State private var navigateToHome = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        	
        NavigationView {
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
                    .padding(.top,20)
                
                Text(emailError)
                    .foregroundColor(.red)
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .font(Font.system(size: 13))
                    .multilineTextAlignment(.leading)
                
                SecureField("Password", text: $password)
                    .frame(height: 50)
                    .foregroundColor(AppColors.primary2)
                    .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 15))
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color(.systemGray6).opacity(0.7))
                    .cornerRadius(30)
                    .padding(.horizontal,20)
                    .padding(.top,10)
                
                Text(passwordError)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.red)
                    .padding(.horizontal, 20)
                    .padding(.top, 0)
                    .font(Font.system(size: 13))
                
                
                    Button(
                        action: {
                            isReset1Active = true
                        }) {
                            
                            Text("Forgot Password?")
                                .foregroundColor(AppColors.primary2)
                                .underline()
                                .padding(.horizontal, 20)
                                .font(Font.system(size: 15))
                                .padding(.top,20)
                            
                        }
                    
                    
                
                
                
                Button(
                    action: {
                        // Perform sign up action
                        withAnimation {
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isLoading = false
                                if verify() {
                                    signUp()
                                    
                                }
                            }
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(2)
                                .padding()
                        } else {
                            Text("Sign In")
                                .padding(.horizontal,110)
                                .foregroundColor(.white)
                                .padding()
                                .background(AppColors.primary2)
                                .cornerRadius(30)
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
                NavigationLink("", destination: Home(token: UserDefaults.standard.string(forKey: "token") ?? "").navigationBarHidden(true), isActive: $navigateToHome).hidden()
                
                HStack {
                    Text("Have an account ?")
                        .foregroundColor(Color.black)
                    
                    
                    NavigationLink(
                                           destination: RegisterView().navigationBarHidden(true),
                                            isActive: $isSignupActive
                                        ) {
                                            Text("Sign up")
                                                .foregroundColor(AppColors.primary2)
                                                .underline()
                                        }
                }
                .padding(.top,30)
            }
            .padding(.horizontal, 20)
            .disabled(viewModel.isLoading)
            .alert(isPresented: $showError) {
                Alert(title: Text(errorTitle).foregroundColor(.red), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(AppColors.primary)
            .onReceive(viewModel.$isAuthenticated) { isAuthenticated in
                isActive = isAuthenticated
                
            }
            .background(
                
                NavigationLink(
                    destination: ForgetView().navigationBarHidden(false),
                    isActive: $isReset1Active
                ) { EmptyView() })
          
        }
      
    }
    
    private func signUp() {
        viewModel.login(email: email, password: password, onSuccess: { token in
            navigateToHome = true
        }, onFailure: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        })
    }
    
   /* private func switchToHome() {
        let loginView = HomeView()
        let transition = AnyTransition.move(edge: .bottom)
            .animation(.easeInOut(duration: 5))
        let loginViewWithTransition = loginView
            .transition(transition)
        let loginVC = UIHostingController(rootView: loginViewWithTransition)
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        navController.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController?.present(navController, animated: true, completion: nil)
        
        presentationMode.wrappedValue.dismiss()
    }*/
    
    private func verify() -> Bool {
        var isValid = true
        
        if email.isEmpty {
            emailError = "Please enter your email"
        }
        else if   !email.isValidEmail {
            emailError = "Invalid email address"
            isValid = false
        }
        else {
            emailError = ""
        }
        
        
        if password.isEmpty  {
            passwordError = "Please enter your password"
            isValid = false
        } else {
            passwordError = ""
        }
        
        return isValid
    }
}
        
           
    
    struct SignInScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SignInScreenView()
        }
    }

