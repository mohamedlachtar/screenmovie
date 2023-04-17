//
//  Content-ViewModel.swift
//  login
//
//  Created by Apple Esprit on 15/3/2023.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @AppStorage("AUTH_KEY") var authenticated = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("USER_KEY") var username = ""
    // Keep filled ONLY for debugging
    @Published var password = "" // Keep filled ONLY for debugging
    @Published var invalid: Bool = false
    
    private var sampleUser = "a"
    private var samplePassword = "a"
    
    
    
    init() {
        // Debugging
        print("Currently logged on: \(authenticated)")
        print("Current user: \(username)")
    }
    
    func toggleAuthentication() {
        // Make sure that the password does not save.
        self.password = ""
        self.username = ""
        
        
        
    }
    
    func authenticate() {
        
            
            // Check for user
            guard self.username.lowercased() == sampleUser else {
                self.invalid = true
                return }
            
            // Check for password
            guard self.password.lowercased() == samplePassword else {
                self.invalid = true
                return }
            
            toggleAuthentication()
        
    }
    
    func logOut() {
        toggleAuthentication()
    }
    
    func logPressed() {
        print("Button pressed.")
    }
    

}
extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

