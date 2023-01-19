//
//  ImagePickerView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.01.2023.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var showAlertSwitcher: Bool
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {

    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let imagePicker: ImagePickerView

        init(_ imagePicker: ImagePickerView) {
            self.imagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                imagePicker.image = uiImage
            } else {
                imagePicker.alertTitle = "Error"
                imagePicker.alertMessage = "Can't load Image"
                imagePicker.showAlertSwitcher.toggle()
            }

            imagePicker.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
