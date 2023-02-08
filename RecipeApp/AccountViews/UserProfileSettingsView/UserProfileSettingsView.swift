//
//  UserProfileSettingsView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 13.01.2023.
//

import SwiftUI

struct UserProfileSettingsView: View {
    
    @State private var name: String = ""
    @State private var imageFormPicker: UIImage?
    @State var alertTitleImagePicker: String = ""
    @State var alertMessageImagePicker: String = ""
    @State var showAlertImagePickerSwitcher: Bool = false
    @State private var showImagePickerSwitcher: Bool = false
    @State private var updateDataInFirebaseProgressView: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 15) {
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)
                Text("Manage your profile")
                    .foregroundColor(.white)
                    .opacity(0.7)
                
                // Image picker button for profile image
                ImageButtonWithGlowIconView(title: "Choose image for profile", defaultSysIcon: "person.crop.circle", imageAfterChange: $imageFormPicker) {
                    showImagePickerSwitcher.toggle()
                }
                .sheet(isPresented: $showImagePickerSwitcher) {
                    ImagePickerView(image: $imageFormPicker, alertTitle: $alertTitleImagePicker, alertMessage: $alertMessageImagePicker, showAlertSwitcher: $showAlertImagePickerSwitcher)
                }
                
                // Name textfield
                TextFieldWithGlowIconView(iconName: "textformat", textPlaceHolder: "Name", text: $name)
                    .textInputAutocapitalization(.words)
                    .textContentType(.name)
                
                // Save settings in DB
                VStack(spacing: 15) {
                    ButtonWithGlowView(title: "Save settings in FireStore") {
                        updateDataInFirebaseProgressView.toggle()
                        firebaseManager.saveUserSettingsInFirebse(name: name, imageFormPicker: imageFormPicker) {
                            firebaseManager.featchUserDataFromFirebase()
                            updateDataInFirebaseProgressView.toggle()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ButtonWithGlowView(title: "Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
            if updateDataInFirebaseProgressView {
                ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .shadowColor))
                    .scaleEffect(1.5)
                    .padding()
            }
        }
        .padding()
        .background {
            Image("background-1")
                .resizable()
                .ignoresSafeArea()
        }
        .onAppear {
            firebaseManager.featchUserDataFromFirebase()
            name = firebaseManager.name
            imageFormPicker = firebaseManager.userImage
        }
        .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher) {} message: {
            Text(firebaseManager.alertMessage)
        }
        .alert(alertTitleImagePicker, isPresented: $showAlertImagePickerSwitcher) {} message: {
            Text(alertMessageImagePicker)
        }
    }
}

struct UserProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileSettingsView()
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
                //                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
            .preferredColorScheme(.dark)
    }
}
