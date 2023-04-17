//
//  userViewModel.swift
//  login
//
//  Created by Floki on 31/3/2023.
//

import Foundation
import  Alamofire
import Combine
import CoreData
import SwiftUI

class UserViewModel: ObservableObject {
    var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated = false
    @Published var isRegistred = false
    private let baseURL = "http://localhost:8080/"
    
    func login(email: String, password: String, onSuccess: @escaping (_ token: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"login" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password ],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<403)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    guard let jsonData = data as? [String: Any],
                          let statusCode = response.response?.statusCode else {
                        onFailure("Error", "Invalid response format")
                        return
                    }

                    switch statusCode {
                    case 200:
                        guard let token = jsonData["token"] as? String,
                              let email = jsonData["email"] as? String,
                              let name = jsonData["username"] as? String,
                              let image = jsonData["image"] as? String
                        else {
                            onFailure("Error", "invalid response body ")
                            return
                        }
                        let user = User(email: email,token: token, name: name,image:image)
                        self.currentUser = user
                        // Store token in UserDefaults
                        UserDefaults.standard.set(token, forKey: "token")
                        UserDefaults.standard.set(name, forKey: "username")
                        UserDefaults.standard.set(image, forKey: "image")
                        
                        // Set isAuthenticated to true and navigate to home page
                        self.isAuthenticated = true
                        onSuccess(token)
                        
                    case 400:
                        onFailure("Login failed", "Invalid password")
                    case 402:
                        onFailure("Account not activated", "Your email address has not been verified")
                    default:
                        onFailure("User not found", "This email address is not associated with any account")
                    }
                case .failure(let error):
                    print(error)
                    onFailure("Error", "Network request failed")
                }
            }
    }

    
    func Signup(email: String, password: String, name: String, onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
            AF.request(baseURL+"signup2" ,
                       method: .post,
                       parameters: [ "email" : email, "password" : password, "username" : name ],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<401)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let jsonData = data as? [String: Any],
                              let statusCode = response.response?.statusCode else {
                            onFailure("Error", "Invalid response format")
                            return
                        }

                        switch statusCode {
                        case 200:
                            self.isRegistred = true
                             onSuccess("Welcome", "Thanks for joining our comunity !")
                        case 400:
                             onFailure("Register failed", "This email is already associated to an account . please use another one or reset your password")
                        default:
                             onFailure("Error", "something went wrong please try again")
                        }
                    case .failure(let error):
                        print(error)
                        onFailure("Error", "Network request failed")
                    }
                }
        }

    
    func forgotPassword(email: String, onSuccess: @escaping () -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
            AF.request(baseURL + "api/test/forgotpassword",
                       method: .post,
                       parameters: ["email": email],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<406)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let jsonData = data as? [String: Any],
                              let statusCode = response.response?.statusCode else {
                            print("Error", "Invalid response format")
                            return
                        }

                        switch statusCode {
                        case 200:
                            onSuccess()
                        case 404:
                            onFailure("message", "User doesn't exist" )
                        default:
                            onFailure("User not found", "This email address is not associated with any account")
                        }
                    case .failure(let error):
                        print(error)
                        onFailure("Error", "Network request failed")
                    }
                }
        }

    func verifyOTP(email: String, otp: String, onSuccess: @escaping () -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
            AF.request("http://localhost:8080/api/test/verifyotp",
                       method: .post,
                       parameters: ["email": email ,"otp": otp],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<406)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let jsonData = data as? [String: Any],
                              let statusCode = response.response?.statusCode else {
                            print("Error", "Invalid response format")
                            return
                        }

                        switch statusCode {
                        case 200:
                            onSuccess()
                        case 404:
                            onFailure("message", "User doesn't exist" )
                        case 400:
                            onFailure("message", "incorrect OTP" )
                        default:
                            onFailure("User not found", "This email address is not associated with any account")
                        }
                    case .failure(let error):
                        print(error)
                        onFailure("Error", "Network request failed")
                    }
                }
        }
    func resetPassword(email: String, password: String,  onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {

            AF.request(baseURL + "api/test/resetpassword",

                       method: .post,

                       parameters: ["email": email ,"newPassword" : password ],

                       encoding: JSONEncoding.default)

            .validate(statusCode: 200..<405)

            .validate(contentType: ["application/json"])

            .responseJSON { response in

                switch response.result {

                case .success(let data):

                    guard let jsonData = data as? [String: Any],

                          let statusCode = response.response?.statusCode else {

                        onFailure("Error", "something went wrong please try again")

                        return

                    }

                    

                    switch statusCode {

                    case 200:

                        self.isRegistred = true

                        onSuccess("Done", "your password has been successfully changed")

                    case 400:

                        onSuccess("Error", "something went wrong please try again")

                    default:

                        onFailure("Error", "user not found")

                        

                    }

                case .failure(let error):

                    print(error)

                    onFailure("Error", "Network request failed")

                }

            }

        }

        
    
}

