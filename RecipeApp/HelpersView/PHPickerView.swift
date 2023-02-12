//
//  PHPickerView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    
    @Binding var resultImages: [UIImage]
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var showAlertSwitcher: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var pickerConfiguration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        pickerConfiguration.filter = .images
        pickerConfiguration.selectionLimit = 3
        
        let pickerViewController = PHPickerViewController(configuration: pickerConfiguration)
        pickerViewController.delegate = context.coordinator
        
        return pickerViewController
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let PHPicker: PHPickerView
        
        init(_ parent: PHPickerView) {
            self.PHPicker = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
          PHPicker.resultImages.removeAll()
          
          for image in results {
            if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
              image.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] newImage, error in
                if let error = error {
                    self?.PHPicker.alertTitle = "Error"
                    self?.PHPicker.alertMessage = "Can't load image \(error.localizedDescription)"
                    self?.PHPicker.showAlertSwitcher.toggle()
                } else if let image = newImage as? UIImage {
                    DispatchQueue.main.async { [weak self] in
                        self?.PHPicker.resultImages.append(image)
                    }
                }
              }
            } else {
                self.PHPicker.alertTitle = "Error"
                self.PHPicker.alertMessage = "Can't load asset"
                self.PHPicker.showAlertSwitcher.toggle()
            }
          }
            picker.dismiss(animated: true)
        }
    }

}
