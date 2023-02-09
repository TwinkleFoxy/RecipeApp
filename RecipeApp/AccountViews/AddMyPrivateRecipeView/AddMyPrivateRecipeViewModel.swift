//
//  AddMyPrivateRecipeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import Foundation
import SwiftUI

protocol AddMyPrivateRecipeViewModelProtocol {
    
}

class AddMyPrivateRecipeViewModel: ObservableObject {
    
    @Published var alertTitleImagePicker: String = ""
    @Published var alertMessageImagePicker: String = ""
    @Published var showAlertImagePickerSwitcher: Bool = false
    
    @Published var showImagePickerSwitcher: Bool = false
    @Published var showImagePHPickerSwitcher: Bool = false
    
    @Published var name: String = ""
    
    @Published var imagePickerForPreviewRecipe: UIImage?
    
    @Published var imagesPHPickerForDescriptionRecipe: [UIImage] = []
    
    @Published var imageForPHPickerPreviewIcon: UIImage?
    
    @Published var category: CategoryRecipe?
    
    @Published var description: String = ""
    @Published var prepTime: String = ""
    @Published var servings: String = ""
    @Published var chill: String = ""
    @Published var cookTime: String = ""
    @Published var totalTime: String = ""
    @Published var yield: String = ""
    
    @Published var ingredients: String = ""
    
    @Published var calories: String = ""
    @Published var totalFat: String = ""
    @Published var saturatedFat: String = ""
    @Published var cholesterol: String = ""
    @Published var sodium: String = ""
    @Published var totalCarbohydrate: String = ""
    @Published var dietaryFiber: String = ""
    @Published var totalSugars: String = ""
    @Published var protein: String = ""
    @Published var metods: String = ""
    
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlertSwitcher: Bool = false
    
    @Published var saveDataInFirebaseProgressView: Bool = false
    
    func saveMyRecipeInFirebase(firebaseManager: FirebaseManager, complition: @escaping () -> ()) {
        if !isEmptyTextfield(textFields: giveStringFromAllTextFields(), category: category) {
            firebaseManager.addUserRecipeDocument(previewImage: imagePickerForPreviewRecipe, descriptionImages: imagesPHPickerForDescriptionRecipe, recipeFirebaseModel: convertToRecipeFirebaseModel()) {
                complition()
            }
        }
    }
    
    
    
    private func isEmptyTextfield(textFields: [String], category: CategoryRecipe?) -> Bool {
        var isEmptyTextfield: Bool = false
        
        for textField in textFields {
            if textField.isEmpty {
                isEmptyTextfield = true
            }
            if (category == nil) {
                isEmptyTextfield =  true
            }
        }
        if isEmptyTextfield {
            alertTitle = "Error"
            alertMessage = "One of Fields is empty. Please check Fields"
            saveDataInFirebaseProgressView.toggle()
            showAlertSwitcher.toggle()
            return true
        } else {
            return false
        }
    }
    
    private func convertToRecipeFirebaseModel() -> RecipeFirebaseModel {
        let nameForSearch = name.lowercased()
        
        let category = category?.rawValue ?? CategoryRecipe.Other.rawValue
        let servingsInt: Int = Int(servings) ?? -1
        
        let yieldInt: Int = Int(yield) ?? -1
        let ingredientsArray: [String] = ingredients.components(separatedBy: "\n")
        let metodsArray: [String] = metods.components(separatedBy: "\n")
        
        let caloriesInt = Int(calories) ?? -1
        let totalFatInt = Int(totalFat) ?? -1
        let saturatedFatInt = Int(saturatedFat) ?? -1
        let cholesterolInt = Int(cholesterol) ?? -1
        let sodiumInt = Int(sodium) ?? -1
        let totalCarbohydrateInt = Int(totalCarbohydrate) ?? -1
        let dietaryFiberInt = Int(dietaryFiber) ?? -1
        let totalSugarsInt = Int(totalSugars) ?? -1
        let proteinInt = Int(protein) ?? -1
        
        return RecipeFirebaseModel(documentID: "", publesherUserID: nil, name: name, nameForSearch: nameForSearch, imagePreviewURL: nil, imagesDescriptionURL: [], category: category, description: description, prepTime: prepTime, servings: servingsInt, chill: chill, cookTime: cookTime, totalTime: totalTime, yield: yieldInt, ingredients: ingredientsArray, calories: caloriesInt, saturatedFat: saturatedFatInt, totalFat: totalFatInt, cholesterol: cholesterolInt, sodium: sodiumInt, totalCarbohydrate: totalCarbohydrateInt, dietaryFiber: dietaryFiberInt, totalSugars: totalSugarsInt, protein: proteinInt, metods: metodsArray)
    }
    
    private func giveStringFromAllTextFields() -> [String] {
        var arrayString: [String] = []
        
        arrayString.append(description)
        arrayString.append(prepTime)
        arrayString.append(servings)
        arrayString.append(chill)
        arrayString.append(cookTime)
        arrayString.append(totalTime)
        arrayString.append(yield)
        arrayString.append(ingredients)
        arrayString.append(calories)
        arrayString.append(totalFat)
        arrayString.append(saturatedFat)
        arrayString.append(cholesterol)
        arrayString.append(sodium)
        arrayString.append(totalCarbohydrate)
        arrayString.append(dietaryFiber)
        arrayString.append(totalSugars)
        arrayString.append(description)
        arrayString.append(description)
        arrayString.append(protein)
        arrayString.append(metods)
        
        return arrayString
    }
}
