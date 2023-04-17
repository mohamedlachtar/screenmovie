

import SwiftUI

struct CreateNewPost: View {

    @State private var description = ""


    @State private var selectedImage: UIImage?
    @State private var showGallery = false
    @State private var showAlert = false

    @EnvironmentObject var postViewModel : PostViewModel
    
    
    @Environment(\.presentationMode) var presentationMode
    
    // Add token as a property
        let token: String

        // Add token as a parameter to the initializer
        init(token: String) {
            self.token = token
        }

    
    var body: some View {

       
            VStack(spacing: 50){

                Button(action:{showGallery = true}){

                    ZStack {

                                        Circle()

                                            .fill(Color.gray.opacity(0.1))

                                            .frame(width: 150, height: 150)

                        if let image = selectedImage{

                            Image(uiImage: image)

                                .resizable()

                                .scaledToFit()

                        }else{

                            Image(systemName: "camera")

                                .font(.system(size: 70))

                                .foregroundColor(AppColors.primary2)

                        }
                                    }
                }.background(AppColors.primary)

                TextField("description", text: $description).padding(.horizontal,20).padding(.vertical,10)

                    .background(RoundedRectangle(cornerRadius: 8).stroke(AppColors.primary2).padding(.horizontal,8))

                
                

                
                

                Button("Add Post", action: {
                    if let selectedImage = selectedImage {
                        postViewModel.createPost(description: description, image: selectedImage, token: token) { result in
                            switch result {
                            case .success:
                                showAlert = true
                            case .failure(let error):
                                print("Error while creating post: \(error.localizedDescription)")
                            }
                        }
                    }
                })


                    
                    .frame(width: 100)

                    .padding()

                    .foregroundColor(AppColors.primary)

                    .background(AppColors.primary2)

                    .cornerRadius(10)

                                

            }

            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(AppColors.primary)
            .sheet(isPresented: $showGallery){

                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
            .background(AppColors.primary)
            .alert(isPresented: $showAlert){
                        Alert(title: Text("Success"),message: Text("Post added successfully"),dismissButton: .default(Text("OK")))
                    }
        }

    

}



struct CreateNewPost_Previews: PreviewProvider {

    static var previews: some View {

        CreateNewPost(token: UserDefaults.standard.string(forKey: "token") ?? "")

    }

}



struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentationMode

    @Binding var selectedImage: UIImage?

    var sourceType: UIImagePickerController.SourceType

    

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePickerController = UIImagePickerController()

        imagePickerController.delegate = context.coordinator

        imagePickerController.sourceType = sourceType

        return imagePickerController

    }

    

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

        

    }

    

    func makeCoordinator() -> Coordinator {

        Coordinator(self)

    }

    

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let parent: ImagePicker

        

        init(_ parent: ImagePicker) {

            self.parent = parent

        }

        

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

                parent.selectedImage = selectedImageFromPicker

            }

            parent.presentationMode.wrappedValue.dismiss()

        }

        

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

            parent.presentationMode.wrappedValue.dismiss()

        }

    }

}


