//
//import SwiftUI
// 
//struct qqqView: View {
//    
//    @State var shouldShowImagePicker = false
//    @State var image: UIImage?
//    @State var username: String = "John Doe"
//    @State var email: String = "johndoe@example.com"
//    @State var profileLink: String = "example.com/profile/johndoe"
//    
//    init() {
//        // Set default image
//        self.image = UIImage(named: "1145988")
//    }
//    
//    var body: some View {
//        NavigationView {
//            ScrollView(.vertical, showsIndicators: true) {
//                VStack {
//                    ZStack() {
//                        Button {
//                            shouldShowImagePicker.toggle()
//                        } label: {
//                            VStack {
//                                if let image = self.image {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 143, height: 143)
//                                        .cornerRadius(90)
//                                } else {
////                                    Image(systemName: "person.circle")
//                                        .font(.system(size: 90))
//                                        .padding()
//                                        .foregroundColor(Color(.label))
//                                }
//                            }
//                        }
//                    }
//                    
//                    VStack {
//                        TextField("Username", text: $username)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(10)
//                            .padding(.horizontal)
//                        
//                        TextField("Email", text: $email)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(10)
//                            .padding(.horizontal)
//                        
//                        TextField("Profile Link", text: $profileLink)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(10)
//                            .padding(.horizontal)
//                    }
//                    
//                    Button(action: {
//                        // Save changes
//                    }) {
//                        Text("Save")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(width: 220, height: 60)
//                            .background(Color.blue)
//                            .cornerRadius(15.0)
//                    }
//                }
//            }
//            .navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.large)
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
//            ImagePicker(image: $image)
//                .ignoresSafeArea()
//        }
//    }
//}
//
//struct qqqView_Previews: PreviewProvider {
//    static var previews: some View {
//        qqqView()
//    }
//}
//
// 
//struct ImagePicker: UIViewControllerRepresentable {
// 
//    @Binding var image: UIImage?
// 
//    private let controller = UIImagePickerController()
// 
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
// 
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
// 
//        let parent: ImagePicker
// 
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
// 
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            parent.image = info[.originalImage] as? UIImage
//            picker.dismiss(animated: true)
//        }
// 
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
//        }
// 
//    }
// 
//    func makeUIViewController(context: Context) -> some UIViewController {
//        controller.delegate = context.coordinator
//        return controller
//    }
// 
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
// 
//    }
// 
//}
//
