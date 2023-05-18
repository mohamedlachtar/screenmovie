//
//  File.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI
import LocalAuthentication
import FBSDKLoginKit

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
    @AppStorage("stored_User") var user = "mohamed.lachtar@esprit.tn"
    @State private var unlocked = false
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email1 = ""
    @State var manager = LoginManager()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Image("zyro")
                    .resizable()
                    .frame(width: 300, height: 300 , alignment: .center)
                
                
                
                TextField("Email", text: $email)
                    .frame(height: 50)
                    .foregroundColor(AppColors.primary2)
                    .accentColor(AppColors.primary2) // Set the accent color to AppColors.primary2
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
                    .accentColor(AppColors.primary2) // Set the accent color to AppColors.primary2
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color(.systemGray6).opacity(0.7))
                    .cornerRadius(30)
                    .padding(.horizontal,20)
                    .padding(.top,20)
                
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
                
                
                
                
                HStack {
                    Button(action: {
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
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColors.primary2)
                                .cornerRadius(30)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    
                    if getBioMetricStatus() {
                        Button(action: Authent) {
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(AppColors.primary2)
                                .clipShape(Circle())
                        }
                    }
                }
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
                    Button(action: {
                        if logged {
                            
                            manager.logOut()
                            email1 = ""
                            logged = false
                            print(logged)
                        }else {
                            
                            manager.logIn(permissions: ["public_profile","email"], from: nil){
                                (result, err) in
                                if err != nil {
                                    print(err!.localizedDescription)
                                    return
                                }
                                
                                logged = true
                                
                                let request = GraphRequest(graphPath: "me", parameters: ["fields" : "email"])
                                
                                request.start { (_, res, _) in
                                    guard let profileDate = res as? [String : Any]
                                    else {
                                        return
                                    }
                                    
                                    email1 = profileDate["email"] as! String
                                    print(email)
                                    
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image("facebook")
                                .resizable()
                                .frame(width: 30 ,height: 30)
                                .offset(x:0)
                            
                            Text("Facebook")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(30)
                    .padding(.top, 10)
                    Spacer()
                    if logged == true {
                        NavigationLink("", destination: Home(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1vaGFtZWQubGFjaHRhckBlc3ByaXQudG4iLCJpYXQiOjE2ODE3MDU2MjZ9.-nBqohi6k6hwvAWWjExcKyp27svPcFn6rfPPUqRVzsU").navigationBarBackButtonHidden(true), isActive: $logged )
                    }
                }
                .padding(.top,30)
                
                
            }
            .padding(.horizontal, 20)
            .disabled(viewModel.isLoading)
            .alert(isPresented: $showError) {
                Alert(title: Text(errorTitle).foregroundColor(.red), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                
            }
            //.frame(maxWidth: .infinity,maxHeight: .infinity)
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
    
    
    func getBioMetricStatus()->Bool{
        
        let scanner = LAContext()
        
        if email == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
            
        {
            
            return true
            
        }
        
        return false
        
    }
    func Authent(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            let reason = "We Need to scan your face. "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason)
            {success, AuthenticationError in
                if success{
                    //authent success
                    unlocked = true
                    navigateToHome = true
                }else{
                    //there was a problem
                }
            }
        }else{
            //no biometrics
        }
    }
    
}
    
    struct SignInScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SignInScreenView()
        }
    }

