//
//  qssq.swift
//  login
//
//  Created by Floki on 6/4/2023.
//

import SwiftUI
struct qssq: View {
        @State var profileImage: Image = Image(systemName: "person.circle")
        @State var userName: String = "John Doe"
        @State var email: String = "johndoe@example.com"
        @State var profileLink: String = "https://example.com/profile/johndoe"
        
        var body: some View {
            VStack {
                profileImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                
                Button(action: {
                    // Code to upload profile picture
                }) {
                    Text("Upload Picture")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                    
                    TextField("Enter name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                    
                    TextField("Enter email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Profile Link")
                        .font(.headline)
                    
                    TextField("Enter profile link", text: $profileLink)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                Button(action: {
                    // Code to save changes to user profile
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Profile")
        }
    }


struct qssqView_Previews: PreviewProvider {
    static var previews: some View {
       qssq()
    }
}
