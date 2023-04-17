//
//  profil2.swift
//  login
//
//  Created by Floki on 12/4/2023.
//

import SwiftUI

struct profil2: View {
    var body: some View {
        struct UserRow: View {
            var userName: String
            var userPicture: Image
            var userComment: String
            
            var body: some View {
                HStack {
                    userPicture
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(userName)
                            .font(.headline)
                        Text(userComment)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }

        struct ContentView: View {
            var users = [
                UserRow(userName: "John", userPicture: Image("user1"), userComment: "Nice photo!"),
                UserRow(userName: "Mary", userPicture: Image("user2"), userComment: "Looks like a fun day!"),
                UserRow(userName: "Tom", userPicture: Image("user3"), userComment: "Great shot!"),
            ]
            
            var body: some View {
                List(users) { user in
                    UserRow(userName: user.userName, userPicture: user.userPicture, userComment: user.userComment)
                }
            }
        }
    }
}

struct profil2_Previews: PreviewProvider {
    static var previews: some View {
        profil2()
    }
}
