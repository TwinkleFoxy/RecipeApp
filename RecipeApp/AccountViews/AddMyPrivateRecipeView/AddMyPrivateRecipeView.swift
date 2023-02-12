//
//  AddMyPrivateRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import SwiftUI

struct AddMyPrivateRecipeView: View {
    
    @ObservedObject var viewModel = AddMyPrivateRecipeViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            if viewModel.saveDataInFirebaseProgressView {
                ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .shadowColor))
                    .scaleEffect(1.5)
                    .padding()
            } else {
                VStack(alignment: .leading) {
                    Text("Add my Recipe")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    ScrollView {
                        VStack {
                            VStack(spacing: 15) {
                                Group {
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Name", text: $viewModel.name)
                                    
                                    // Image picker button for preview recipe
                                    ImageButtonWithGlowIconView(title: "Choose one image for preview", defaultSysIcon: "person.crop.circle", imageAfterChange: $viewModel.imagePickerForPreviewRecipe) {
                                        viewModel.showImagePickerSwitcher.toggle()
                                    }
                                    .sheet(isPresented: $viewModel.showImagePickerSwitcher) {
                                        ImagePickerView(image: $viewModel.imagePickerForPreviewRecipe, alertTitle: $viewModel.alertTitleImagePicker, alertMessage: $viewModel.alertMessageImagePicker, showAlertSwitcher: $viewModel.showAlertImagePickerSwitcher)
                                    }
                                    
                                    // Image PHPicker button for description recipe
                                    ImageButtonWithGlowIconView(title: "Choose one or max three images for description", defaultSysIcon: "person.crop.circle", imageAfterChange: $viewModel.imageForPHPickerPreviewIcon) {
                                        viewModel.showImagePHPickerSwitcher.toggle()
                                    }
                                    .sheet(isPresented: $viewModel.showImagePHPickerSwitcher) {
                                        PHPickerView(resultImages: $viewModel.imagesPHPickerForDescriptionRecipe, alertTitle: $viewModel.alertTitleImagePicker, alertMessage: $viewModel.alertMessageImagePicker, showAlertSwitcher: $viewModel.showAlertImagePickerSwitcher)
                                    }
                                    .onChange(of: viewModel.imagesPHPickerForDescriptionRecipe) { newValue in
                                        viewModel.imageForPHPickerPreviewIcon = newValue.first
                                    }
                                    
                                    CategoryRecipeView(placeHolder: "Category Recipe (Scrollable)", selectedCategory: $viewModel.category)
                                }
                                
                                Group {
                                    
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Description", text: $viewModel.description)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Prep time min (enter number)", text: $viewModel.prepTime)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Servings (enter number)", text: $viewModel.servings)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Chill min (enter number)", text: $viewModel.chill)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Cook time min (enter number)", text: $viewModel.cookTime)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Total time min (enter number)", text: $viewModel.totalTime)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Yield (enter number)", text: $viewModel.yield)
                                        .keyboardType(.numberPad)
                                }
                                .padding(.leading, 25)
                                
                                TextEditorView(textPlaceHolder: "Ingredients (Enter each ingredient on a new line)", text: $viewModel.ingredients)
                                
                                Group {
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Calories (enter number)", text: $viewModel.calories)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Total fat (enter number)", text: $viewModel.totalFat)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Saturated fat (enter number)", text: $viewModel.saturatedFat)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Cholesterol (enter number)", text: $viewModel.cholesterol)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Sodium (enter number)", text: $viewModel.sodium)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "TotalCarbohydrate (enter number)", text: $viewModel.totalCarbohydrate)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Dietary fiber (enter number)", text: $viewModel.dietaryFiber)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Total sugars (enter number)", text: $viewModel.totalSugars)
                                        .keyboardType(.numberPad)
                                    TextFieldWithGlowIconView(iconName: "star", textPlaceHolder: "Protein (enter number)", text: $viewModel.protein)
                                        .keyboardType(.numberPad)
                                }
                                .padding(.leading, 25)
                                
                                TextEditorView(textPlaceHolder: "Metods (Enter each step on a new line)", text: $viewModel.metods)
                            }
                            
                            VStack {
                                ButtonWithGlowView(title: "Add recipe in my list") {
                                    viewModel.saveDataInFirebaseProgressView.toggle()
                                    viewModel.saveMyRecipeInFirebase(firebaseManager: firebaseManager) {
                                        viewModel.saveDataInFirebaseProgressView.toggle()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                ButtonWithGlowView(title: "Cancel") {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 55)
                        }
                    }
                }
                .padding(.top, 80)
                .padding(.horizontal)
                .alert(viewModel.alertTitleImagePicker, isPresented: $viewModel.showAlertImagePickerSwitcher) {} message: {
                    Text(viewModel.alertMessageImagePicker)
                }
                .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher) {} message: {
                    Text(firebaseManager.alertMessage)
                }
                .alert(viewModel.alertTitle, isPresented: $viewModel.showAlertSwitcher) {} message: {
                    Text(viewModel.alertMessage)
                }
            }
        }
        
    }
}

struct AddMyPrivateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddMyPrivateRecipeView()
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
                //                firebaseManager.searchRecipe(searchText: "", by: "nameForSearch", inCollection: "Recipe", limitToReceive: 100)
                return firebaseManager
            }() )
    }
}
