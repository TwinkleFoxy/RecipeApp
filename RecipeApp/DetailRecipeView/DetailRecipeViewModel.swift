//
//  DetailRecipeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import Foundation
import SwiftUI

protocol DetailRecipeViewModelProtocol {
    var name: String { get }
    var imageURL: String? { get }
    var imagesURL: [String] { get }
    var aboutRecipeModel: AboutRecipeModel { get }
    var nutritionRecipeModel: NutritionRecipeModel { get }
    var ingredients: [String] { get }
    var metods: [String] { get }
    init(recipeFirebaseModel: RecipeFirebaseModel)
    func topRightButtonPressed(isUserRecipe: Bool, firebaseManager: FirebaseManager, documentID: String, presentationMode: Binding<PresentationMode>)
    func confirmedDeleteRecipeFromAllert(firebaseManager: FirebaseManager, presentationMode: Binding<PresentationMode>)
}

class DetailRecipeViewModel: DetailRecipeViewModelProtocol, ObservableObject {
    
    @Published var showAlertSwitcherAuth: Bool = false
    @Published var alertTitleAuth: String = ""
    @Published var alertMessageAuth: String = ""
    
    @Published var showAlertSwitcherConfirmDeleteUserRecipe: Bool = false
    @Published var alertTitleConfirmDeleteUserRecipe: String = ""
    @Published var alertMessageConfirmDeleteUserRecipe: String = ""
    
    var documentID: String {
        recipeFirebaseModel.documentID
    }
    
    var name: String {
        recipeFirebaseModel.name
    }
    
    var imageURL: String? {
        recipeFirebaseModel.imagePreviewURL
    }
    
    var imagesURL: [String] {
        if recipeFirebaseModel.imagesDescriptionURL?.isEmpty ?? true {
            return [""]
        } else {
            return recipeFirebaseModel.imagesDescriptionURL ?? [""]
        }
    }
    
    var aboutRecipeModel: AboutRecipeModel {
        
        var servings = ""
        var yield = ""
        
        if let tempServings = recipeFirebaseModel.servings {
            servings = tempServings != -1 ? String(tempServings) : "No data"
        } else { servings = "No data" }
        
        if let tempYield = recipeFirebaseModel.servings {
            yield = tempYield != -1 ? String(tempYield) : "No data"
        } else { yield = "No data" }
        
        return AboutRecipeModel(timePrep: recipeFirebaseModel.prepTime,
                                timeChill: recipeFirebaseModel.chill,
                                servings: servings,
                                timeCook: recipeFirebaseModel.cookTime,
                                timeTotal: recipeFirebaseModel.totalTime, yield: yield,
                                dishDescription: recipeFirebaseModel.description)
    }
    
    var nutritionRecipeModel: NutritionRecipeModel {
        
        var calories = ""
        var totalFat = ""
        var saturatedFat = ""
        var cholesterol = ""
        var sodium = ""
        var totalCarbohydrate = ""
        var dietaryFiber = ""
        var totalSugars = ""
        var protein = ""
        
        if let tempCalories = recipeFirebaseModel.calories {
            calories = tempCalories != -1 ? String(tempCalories) : "No data"
        } else { calories = "No data" }
        
        if let tempTotalFat = recipeFirebaseModel.totalFat {
            totalFat = tempTotalFat != -1 ? "\(tempTotalFat) g" : "No data"
        } else { totalFat = "No data" }
        
        if let tempSaturatedFat = recipeFirebaseModel.saturatedFat {
            saturatedFat = tempSaturatedFat != -1 ? "\(tempSaturatedFat) g" : "No data"
        } else { saturatedFat = "No data" }
        
        if let tempCholesterol = recipeFirebaseModel.cholesterol {
            cholesterol = tempCholesterol != -1 ? "\(tempCholesterol) mg" : "No data"
        } else { cholesterol = "No data" }
        
        if let tempSodium = recipeFirebaseModel.sodium {
            sodium = tempSodium != -1 ? "\(tempSodium) mg" : "No data"
        } else { sodium = "No data" }
        
        if let tempTotalCarbohydrate = recipeFirebaseModel.totalCarbohydrate {
            totalCarbohydrate = tempTotalCarbohydrate != -1 ? "\(tempTotalCarbohydrate) g" : "No data"
        } else { totalCarbohydrate = "No data" }
        
        if let tempDietaryFiber = recipeFirebaseModel.dietaryFiber {
            dietaryFiber = tempDietaryFiber != -1 ? "\(tempDietaryFiber) g" : "No data"
        } else { dietaryFiber = "No data" }
        
        if let tempTotalSugars = recipeFirebaseModel.totalSugars {
            totalSugars = tempTotalSugars != -1 ? "\(tempTotalSugars) g" : "No data"
        } else { totalSugars = "No data" }
        
        if let tempProtein = recipeFirebaseModel.protein {
            protein = tempProtein != -1 ? "\(tempProtein) g" : "No data"
        } else { protein = "No data" }
        
        return NutritionRecipeModel(calories: calories,
                                    totalFat: totalFat,
                                    saturatedFat: saturatedFat,
                                    cholesterol: cholesterol,
                                    sodium: sodium,
                                    totalCarbohydrate: totalCarbohydrate,
                                    dietaryFiber: dietaryFiber,
                                    totalSugars: totalSugars,
                                    protein: protein)
    }
    
    var ingredients: [String] {
        recipeFirebaseModel.ingredients
    }
    
    var metods: [String] {
        recipeFirebaseModel.metods
    }
    
    private let recipeFirebaseModel: RecipeFirebaseModel
    
    required init(recipeFirebaseModel: RecipeFirebaseModel) {
        self.recipeFirebaseModel = recipeFirebaseModel
    }
    
    func topRightButtonPressed(isUserRecipe: Bool, firebaseManager: FirebaseManager, documentID: String, presentationMode: Binding<PresentationMode>) {
        if isUserRecipe {
            alertTitleConfirmDeleteUserRecipe = "Delete this recipe"
            alertMessageConfirmDeleteUserRecipe = "Are you sure to delete the recipe?"
            showAlertSwitcherConfirmDeleteUserRecipe.toggle()
        } else {
            toggleFavouriteStatusRecipeInFirebase(firebaseManager: firebaseManager)
        }
    }
    
    func confirmedDeleteRecipeFromAllert(firebaseManager: FirebaseManager, presentationMode: Binding<PresentationMode>) {
        if firebaseManager.signInSwitcher {
            firebaseManager.deliteUserRecipeDocument(documentIDNameUserRecipeForDelete: documentID) {
                presentationMode.wrappedValue.dismiss()
            }
        } else {
            alertTitleAuth = "You not authorised in Account"
            alertMessageAuth = "Please login or register in tab Account. Then you can add recipe in favourite list."
            showAlertSwitcherAuth.toggle()
        }
    }
    
    private func toggleFavouriteStatusRecipeInFirebase(firebaseManager: FirebaseManager) {
        if firebaseManager.signInSwitcher {
            firebaseManager.togleFavouriteStatusInFirebase(forRecipe: documentID)
        } else {
            alertTitleAuth = "You not authorised in Account"
            alertMessageAuth = "Please login or register in tab Account. Then you can add recipe in favourite list."
            showAlertSwitcherAuth.toggle()
        }
    }
}
