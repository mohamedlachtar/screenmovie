////
//
////  AddBaby.swift
//
////  Babylo
//
////
//
////  Created by Babylo  on 6/4/2023.
//
////
//
//
//
//import SwiftUI
//
//
//
//struct AddBaby: View {
//
//
//
//    @State private var babyName = ""
//
//
//
//    @State private var selectedDate = Date()
//
//
//
//    @State private var selectedImage: UIImage?
//
//
//
//    @State private var selectedGender = 0
//
//
//
//    @State private var showGallery = false
//
//
//
//    @State private var showAlert = false
//
//
//
//    @EnvironmentObject var psotsViewModel : PostsViewModel
//
//
//
//    @Environment(\.presentationMode) var presentationMode
//
//
//
//    // Add token as a property
//
//        let token: String
//
//
//
//        // Add token as a parameter to the initializer
//
//        init(token: String) {
//
//            self.token = token
//
//        }
//
//
//
//
//
//    var body: some View {
//
//
//
//
//
//            VStack(spacing: 50){
//
//
//
//                Button(action:{showGallery = true}){
//
//
//
//                    ZStack {
//
//
//
//                                        Circle()
//
//
//
//                                            .fill(Color.gray.opacity(0.1))
//
//
//
//                                            .frame(width: 150, height: 150)
//
//
//
//                        if let image = selectedImage{
//
//
//
//                            Image(uiImage: image)
//
//
//
//                                .resizable()
//
//
//
//                                .scaledToFit()
//
//
//
//                        }else{
//
//
//
//                            Image(systemName: "plus")
//
//
//
//                                .font(.system(size: 70))
//
//
//
//                                .foregroundColor(.yellow)
//
//
//
//                        }
//
//                                    }
//
//                }
//
//
//
//                TextField("Baby name", text: $babyName).padding(.horizontal,20).padding(.vertical,10)
//
//
//
//                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow).padding(.horizontal,8))
//
//
//
//
//
//                Picker("Gender",selection: $selectedGender){
//
//                    Text("Boy").tag(0)
//
//                    Text("Girl").tag(1)
//
//
//
//                }.pickerStyle(SegmentedPickerStyle())
//
//                    .padding(.horizontal,20)
//
//
//
//
//
//                DatePicker(selection: $selectedDate, displayedComponents: .date){Text("Select baby's birthday" ).bold()}.padding(.horizontal,20)
//
//
//
//
//
//
//
//                Button("Add Baby", action: {
//
//                    let genderString = selectedGender == 0 ? "Boy" : "Girl"
//
//                    if let selectedImage = selectedImage {
//
//                        PostsViewModel.addPost(token:token, description: description	, imageUrl: selectedImage) { result in
//
//                                            switch result {
//
//                                            case .success:
//
//                                                showAlert=true
//
//                                            case .failure(let error):
//
//                                                print("Error adding baby: \(error.localizedDescription)")
//
//                                            }
//
//                                        }
//
//                                    }
//
//
//
//                })
//
//
//
//                    .frame(width: 100)
//
//
//
//                    .padding()
//
//
//
//                    .foregroundColor(.white)
//
//
//
//                    .background(Color.yellow)
//
//
//
//                    .cornerRadius(10)
//
//
//
//
//
//
//
//            }
//
//
//
//            .padding()
//
//
//
//            .sheet(isPresented: $showGallery){
//
//
//
//                PostPicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
//
//        }
//
//            .alert(isPresented: $showAlert){
//
//                        Alert(title: Text("Success"),message: Text("Baby added successfully"),dismissButton: .default(Text("OK")))
//
//                    }
//
//        }
//
//
//
//
//
//
//
//}
//
//
//
//
//
//
//
//struct AddBaby_Previews: PreviewProvider {
//
//
//
//    static var previews: some View {
//
//
//
//        AddBaby(token: UserDefaults.standard.string(forKey: "token") ?? "")
//
//
//
//    }
//
//
//
//}
//
//
//
//
//
//
//
//struct PostPicker: UIViewControllerRepresentable {
//
//
//
//    @Environment(\.presentationMode) var presentationMode
//
//
//
//    @Binding var selectedImage: UIImage?
//
//
//
//    var sourceType: UIImagePickerController.SourceType
//
//
//
//
//
//
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<PostPicker>) -> UIImagePickerController {
//
//
//
//        let imagePickerController = UIImagePickerController()
//
//
//
//        imagePickerController.delegate = context.coordinator
//
//
//
//        imagePickerController.sourceType = sourceType
//
//
//
//        return imagePickerController
//
//
//
//    }
//
//
//
//
//
//
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PostPicker>) {
//
//
//
//
//
//
//
//    }
//
//
//
//
//
//
//
//    func makeCoordinator() -> Coordinator {
//
//
//
//        Coordinator(self)
//
//
//
//    }
//
//
//
//
//
//
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//
//
//        let parent: PostPicker
//
//
//
//
//
//
//
//        init(_ parent: PostPicker) {
//
//
//
//            self.parent = parent
//
//
//
//        }
//
//
//
//
//
//
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//
//
//            if let selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//
//
//
//                parent.selectedImage = selectedImageFromPicker
//
//
//
//            }
//
//
//
//            parent.presentationMode.wrappedValue.dismiss()
//
//
//
//        }
//
//
//
//
//
//
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//
//
//            parent.presentationMode.wrappedValue.dismiss()
//
//
//
//        }
//
//
//
//    }
//
//
//
//}
//
