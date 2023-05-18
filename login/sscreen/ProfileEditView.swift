////
////  ProfileEditView.swift
////  login
////
////  Created by Floki on 28/3/2023.
////
//
//import SwiftUI
//
//struct ProfileEditView: View {
//    @StateObject var vm = ViewModel()
//    @State private var username: String = ""
//    @State private var email: String = ""
//    @State private var name: String = ""
//    @State private var bio: String = ""
//    @State private var link: String = ""
//   // @Environment(\.presentationMode) var presentationMode
//    @State var isShowAlert = false
//    @State var isPasswordResetSuccess = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Username", text: $username)
//                    TextField("Email", text: $email)
//                    TextField("Name", text: $name)
//                    //TextField("Bio", text: $bio)
//                    //TextField("Link", text: $link)
//                }
//
//                
//            }
//            .navigationBarBackButtonHidden(true)
//            .navigationTitle(Text("Edit Profile"))
//            .navigationBarItems(leading: Button(action: {
//               // self.presentationMode.wrappedValue.dismiss()
//            }, label: {
//                Text("Cancel")
//            }), trailing: Button(action: {
//
//            }, label: {
//                Text("Done")
//            }))
//            .alert(isPresented: $isShowAlert, content: {
//              if self.isPasswordResetSuccess {
//                    return Alert(title: Text("Password Reset"),
//                                 message: Text("Please check your email for directions on how to reset your password"),
//                                 dismissButton: .default(Text("Ok"), action: {
//                                 //   self.presentationMode.wrappedValue.dismiss()
//                                 })
//                    )
//                } else {
//                    return Alert(title: Text("Updates Saved"),
//                                 message: Text("All changes saved!"),
//                                 dismissButton: .default(Text("Ok"), action: {
//                                   // self.presentationMode.wrappedValue.dismiss()
//                                 })
//                    )
//                }
//
//            })
//        }
//    }
//}
//
//struct ProfileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditView()
//    }
//}
