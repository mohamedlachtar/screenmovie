
//import SwiftUI
//
//struct ProfileView: View {
//    @ObservedObject var postViewModel = PostViewModel()
//    @State var username = "hama"
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showNewPassword = false
//    @State private var showNewUsername = false
//    @State private var isNavigateToLogin = false
//    @AppStorage("isDarkMode") private var isDarkMode = false
//
//    var body: some View {
//        VStack {
//            VStack {
//                Toggle(isOn: $isDarkMode) {
//                    Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
//                        .foregroundColor(isDarkMode ? .yellow : .orange)
//                }
//                .padding(.top, 20)
//                .padding(.trailing, 20)
//                .frame(maxWidth: .infinity, alignment: .trailing)
//            }
//
//            VStack {
//                Image("user1")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                Text(username)
//                    .font(.title)
//            }
//            HStack{
//            Button(action: {
//                self.showNewPassword = true
//            }) {
//                Image(systemName: "lock.fill")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
//                    .background(Color.blue)
//                    .cornerRadius(15)
//                    .accessibility(label: Text("Edit Password"))
//            }
//            .sheet(isPresented: $showNewPassword) {
//                NewPassword()
//            }
//            .padding(.top, 20)
//
//            Button(action: {
//                self.showNewUsername = true
//            }) {
//                Image(systemName: "person.fill")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
//                    .background(Color.blue)
//                    .cornerRadius(15)
//                    .accessibility(label: Text("Edit Username"))
//            }
//            .sheet(isPresented: $showNewUsername) {
//                NewUsername()
//            }
//            .padding(.top, 20)
//        }
//            VStack {
//                postUser().scrollContentBackground(.hidden)
//            }
//
//            Button(action: {
//                resetUserDefaults()
//                isNavigateToLogin = true
//            }) {
//                Text("Logout")
//                    .foregroundColor(.white)
//                    .padding(8)
//                    .font(.system(size: 15))
//                    .frame(width: 140, height: 35)
//                    .background(Color.red)
//                    .cornerRadius(15)
//            }
//            .fullScreenCover(isPresented: $isNavigateToLogin) {
//                SignInScreenView()
//            }
//            .padding(.top, 20)
//        }
//        .padding()
//        .background(isDarkMode ? Color.black : Color.white)
//        .foregroundColor(isDarkMode ? Color.white : Color.black)
//        .onAppear {
//            postViewModel.getUserPost()
//            if let name = UserDefaults.standard.string(forKey: "username") {
//                self.username = name
//            }
//        }
//    }
//}
//struct NewPassword: View {
//    @State private var newPassword = ""
//    @State private var confirmPassword = ""
//
//    var body: some View {
//        VStack {
//            Text("New Password").font(.title)
//            TextField("Enter new password", text: $newPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            TextField("Confirm new password", text: $confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the password
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
////
//struct NewUsername: View {
//    @State private var newUsername = ""
//
//    var body: some View {
//        VStack {
//            Text("New Username").font(.title)
//            TextField("Enter new username", text: $newUsername)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the username
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
//func resetUserDefaults() {
//    let domain = Bundle.main.bundleIdentifier!
//    UserDefaults.standard.removePersistentDomain(forName: domain)
//    UserDefaults.standard.synchronize()
//}
//
//
//
//func loadLastLoggedEmail() -> String? {
//    return UserDefaults.standard.string(forKey: "lastLoggedEmail")
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//
//
//}

import SwiftUI

struct ProfileView: View {
    @ObservedObject var postViewModel = PostViewModel()
    @State var username = "hama"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showNewPassword = false
    @State private var showNewUsername = false
    @State private var isNavigateToLogin = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack {
            VStack {
                Toggle(isOn: $isDarkMode) {
                    Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                        .foregroundColor(isDarkMode ? .yellow : .orange)
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            VStack {
                Image("user1")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                Text(username)
                    .font(.title)
            }
            HStack{
                Button(action: {
                    self.showNewPassword = true
                }) {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(AppColors.primary2)
                        .cornerRadius(15)
                        .accessibility(label: Text("Edit Password"))
                }
                .sheet(isPresented: $showNewPassword) {
                    NewPassword()
                }
                .padding(.top, 20)
                
                
            }
            
            VStack {
                postUser().scrollContentBackground(.hidden)
            }
            
            Button(action: {
                resetUserDefaults()
                isNavigateToLogin = true
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding(8)
                    .font(.system(size: 15))
                    .frame(width: 140, height: 35)
                    .background(Color.red)
                    .cornerRadius(15)
            }
            .fullScreenCover(isPresented: $isNavigateToLogin) {
                SignInScreenView()
            }
            .padding(.top, 20)
        }
        .padding()
        .background(isDarkMode ? Color.black : Color.white)
        .foregroundColor(isDarkMode ? Color.white : Color.black)
        .onAppear {
            postViewModel.getUserPost()
            if let name = UserDefaults.standard.string(forKey: "username") {
                self.username = name
            }
        }
    }
}

struct NewPassword: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            Text("New Password").font(.title)
            TextField("Enter new password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Confirm new password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                // TODO: Change the password
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct NewUsername: View {
    @State private var newUsername = ""

    var body: some View {
        VStack {
            Text("New Username").font(.title)
            TextField("Enter new username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                // TODO: Change the username
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

func resetUserDefaults() {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



// -------1-------
//struct NewPassword: View {
//    @State private var newPassword = ""
//    @State private var confirmPassword = ""
//
//    var body: some View {
//        VStack {
//            Text("New Password").font(.title)
//            TextField("Enter new password", text: $newPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            TextField("Confirm new password", text: $confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the password
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 30)
//                    .background(Color.blue)
//                    .cornerRadius(5)
//            }
//
//        }
//        .padding()
//    }
//}
//----2-----
//struct NewUsername: View {
//    @State private var newUsername = ""
//
//    var body: some View {
//        VStack {
//            Text("New Username").font(.title)
//            TextField("Enter new username", text: $newUsername)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the username
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 30)
//                    .background(Color.blue)
//                    .cornerRadius(5)
//            }
//        }
//        .padding()
//    }
//}




//import SwiftUI
//
//struct ProfileView: View {
//    @ObservedObject var postViewModel = PostViewModel()
//    @State var username = "hama"
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showNewPassword = false
//    @State private var showNewUsername = false
//    @State private var isNavigateToLogin = false
//    @AppStorage("isDarkMode") private var isDarkMode = false
//    var body: some View {
//
//        VStack {
//VStack {
//    Toggle(isOn: $isDarkMode) {
//        Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
//            .foregroundColor(isDarkMode ? .yellow : .orange)
//
//    }
//}
//.padding(.top, 20)
//.padding(.trailing, 20)
//.frame(maxWidth: .infinity, alignment: .trailing)
//            VStack {
//                Image("user1")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                Text(username)
//                    .font(.title)
//
//            }
//
//            Button(action: {
//                // Set the state variable `showNewPassword` to true to show the NewPassword screen
//                self.showNewPassword = true
//            }) {
//                Image(systemName: "lock.fill") // Replace with your desired icon
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 30)
//                    .background(Color.blue)
//                    .cornerRadius(5)
//                    .accessibility(label: Text("Edit Password")) // Add accessibility label
//            }
//            .sheet(isPresented: $showNewPassword) {
//                // Show the NewPassword screen as a modal sheet
//                newpassword()
//            }
//
//            Button(action: {
//                // Navigate to the NewUsername screen
//                self.showNewUsername = true
//            }) {
//                Image(systemName: "person.fill") // Replace with your desired icon
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 30)
//                    .background(Color.blue)
//                    .cornerRadius(5)
//                    .accessibility(label: Text("Edit Username")) // Add accessibility label
//            }
//            .sheet(isPresented: $showNewUsername) {
//                // Show the NewUsername screen as a modal sheet
//                newusername()
//            }
//
//            VStack {
//                // Add any other content you want to display here
//                postUser().scrollContentBackground(.hidden)
//            }
//
//
//
//       Button(action: {
//resetUserDefaults()
//// Additional code to perform logout action
//isNavigateToLogin = true
//}) {
//Text("Logout")
//    .foregroundColor(.white)
//    .padding(8)
//    .font(.system(size: 15))
//    .frame(width: 140, height: 35)
//    .background(Color.red)
//    .cornerRadius(15)
//}
//.fullScreenCover(isPresented: $isNavigateToLogin) {
//SignInScreenView()
//}
//        }
//        .padding()
//        .onAppear {
//            postViewModel.getUserPost()
//            // Get username from UserDefaults and assign it to the `username` state variable
//            if let name = UserDefaults.standard.string(forKey: "username") {
//                self.username = name
//            }
//        }
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
//
//////  1 //////
//struct NewPassword: View {
//    @State private var newPassword = ""
//    @State private var confirmPassword = ""
//
//    var body: some View {
//        VStack {
//            Text("New Password").font(.title)
//            TextField("Enter new password", text: $newPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            TextField("Confirm new password", text: $confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the password
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
////
//struct NewUsername: View {
//    @State private var newUsername = ""
//
//    var body: some View {
//        VStack {
//            Text("New Username").font(.title)
//            TextField("Enter new username", text: $newUsername)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the username
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
//func resetUserDefaults() {
//    let domain = Bundle.main.bundleIdentifier!
//    UserDefaults.standard.removePersistentDomain(forName: domain)
//    UserDefaults.standard.synchronize()
//}
//
//
//
//func loadLastLoggedEmail() -> String? {
//    return UserDefaults.standard.string(forKey: "lastLoggedEmail")
//}

//import SwiftUI
//
//struct ProfileView: View {
//    // Use @StateObject instead of @ObservedObject for better memory management
//    @StateObject var postViewModel = PostViewModel()
//    @State private var username = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showNewPassword = false
//    @State private var showNewUsername = false
//    @State private var isNavigateToLogin = false
//    @AppStorage("isDarkMode") private var isDarkMode = false
//
//    var body: some View {
//        VStack {
//            VStack {
//                Toggle(isOn: $isDarkMode) {
//                    Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
//                        .foregroundColor(isDarkMode ? .yellow : .orange)
//                    Text("Dark Mode")
//                }
//            }
//            .padding(.top, 20)
//            .padding(.trailing, 20)
//            .frame(maxWidth: .infinity, alignment: .trailing)
//
//            ZStack {
//                Image("user1")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                Text(username)
//                    .font(.title)
//                    .clipShape(Circle())
//            }
//            .padding(.top, 30)
//
//            HStack(spacing: 20) {
//                Button(action: {
//                    // Set the state variable `showNewPassword` to true to show the NewPassword screen
//                    self.showNewPassword = true
//                }) {
//                    Image(systemName: "lock.fill") // Replace with your desired icon
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .accessibility(label: Text("Edit Password")) // Add accessibility label
//                }
//                .sheet(isPresented: $showNewPassword) {
//                    // Show the NewPassword screen as a modal sheet
//                    NewPassword()
//                }
//
//                Button(action: {
//                    // Navigate to the NewUsername screen
//                    self.showNewUsername = true
//                }) {
//                    Image(systemName: "person.crop.circle.fill") // Replace with your desired icon
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                        .accessibility(label: Text("Edit Username")) // Add accessibility label
//                }
//                .sheet(isPresented: $showNewUsername) {
//                    // Show the NewUsername screen as a modal sheet
//                    NewUsername()
//                }
//            }
//            .padding(.top, 20)
//
////            ScrollView(.horizontal, showsIndicators: false) {
////                HStack(spacing: 20) {
////                    ForEach(postViewModel.userPosts) { post in
////                     //   PostCardView(post: post)
////                            .frame(width: 300)
////                    }
////                }
////                .padding(.horizontal)
////            }
//            .padding(.top, 30)
//
//            Spacer()
//
//            Button(action: {
//                resetUserDefaults()
//                // Additional code to perform logout action
//                isNavigateToLogin = true
//            }) {
//                Text("Logout")
//                    .foregroundColor(.white)
//                    .padding(8)
//                    .font(.system(size: 15))
//                    .frame(width: 140, height: 35)
//                    .background(Color.red)
//                    .cornerRadius(15)
//            }
//            .fullScreenCover(isPresented: $isNavigateToLogin) {
//                SignInScreenView()
//            }
//        }
//        .padding()
//        .onAppear {
//            postViewModel.getUserPost()
//            // Get username from UserDefaults and assign it to the `username` state variable
//            if let name = UserDefaults.standard.string(forKey: "username") {
//                self.username = name
//            }
//        }
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
//
//struct NewPassword: View {
//    @State private var newPassword = ""
//    @State private var confirmPassword = ""
//
//    var body: some View {
//        VStack {
//            Text("New Password").font(.title)
//            TextField("Enter new password", text: $newPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            TextField("Confirm new password", text: $confirmPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the password
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
//
//struct NewUsername: View {
//    @State private var newUsername = ""
//
//    var body: some View {
//        VStack {
//            Text("New Username").font(.title)
//            TextField("Enter new username", text: $newUsername)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            Button(action: {
//                // TODO: Change the username
//            }) {
//                Text("Save")
//                    .foregroundColor(.white)
//                    .padding(10)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//}
//
////struct PostCardView: View {
////    let post: Post
////
////    var body: some View {
////        VStack(alignment: .leading, spacing: 10) {
////           // Image(post.imageNameProperty)
////                .resizable()
////            //    .aspectRatio(contentMode: .fill)
////                .frame(height: 200)
////                .cornerRadius(10)
////           // Text(post.titleProperty)
////                .font(.headline)
////            Text(post.description)
////                .font(.subheadline)
////        }
////        .padding()
////        .background(Color.white)
////        .cornerRadius(10)
////        .shadow(radius: 5)
////    }
////}
//
//func resetUserDefaults() {
//    let domain = Bundle.main.bundleIdentifier!
//    UserDefaults.standard.removePersistentDomain(forName: domain)
//    UserDefaults.standard.synchronize()
//}
