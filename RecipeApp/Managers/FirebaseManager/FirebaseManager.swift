//
//  FirebaseManager.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

import FirebaseFirestore
import FirebaseCore

class FirebaseManager: ObservableObject {
    @Published var publicRecipe: [RecipeFirebaseModel] = []
    @Published var filteredRecipe: [RecipeFirebaseModel] = []
    @Published var searchedRecipeForHomeView: [RecipeFirebaseModel] = []
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlertSwitcher: Bool = false
    @Published var name: String = "Your name"
    
    //MARK: - Firebase Firestore
    func featchPublicRecipeWithMaxLimit(limit: Int = 10000) {
        DispatchQueue.main.async { [unowned self] in
            publicRecipe.removeAll()
            
            let db = Firestore.firestore()
            
            db.collection("Recipe").limit(to: limit).getDocuments { [unowned self] querySnapshot, error in
                
                let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
                
                if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                    publicRecipe = arrayRecipeFirebaseModel
                }
            }
        }
    }
    
    func featchAndFilterRecipeFieldIsEqualTo(collectionName: String, field: String, equalTo: Any, limitToReceive: Int = 1000) {
        DispatchQueue.main.async { [unowned self] in
            filteredRecipe.removeAll()
            
            let db = Firestore.firestore()
            
            db.collection(collectionName).whereField(field, isEqualTo: equalTo).getDocuments { [unowned self] querySnapshot, error in
                
                let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
                
                if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                    filteredRecipe = arrayRecipeFirebaseModel
                }
            }
        }
    }
    
    func searchRecipeForHomeView(searchText: String, limitToReceive: Int = 1000) {
        DispatchQueue.main.async { [unowned self] in
            searchedRecipeForHomeView.removeAll()
            searchRecipe(searchText: searchText, byField: "nameForSearch", inCollection: "Recipe", limitToReceive: limitToReceive) { [unowned self] searchedRecipe in
                searchedRecipeForHomeView = searchedRecipe
            }
        }
    }
    
    
    private func searchRecipe(searchText: String, byField name: String, inCollection nameCollection: String, limitToReceive: Int = 100000, clousere: @escaping ([RecipeFirebaseModel])->()) {
        
        let db = Firestore.firestore()
        
        var startSearchArray: [String] = []
        startSearchArray.append(searchText.lowercased())
        var searchResultArray: [RecipeFirebaseModel] = []
        
        db.collection(nameCollection).limit(to: limitToReceive).order(by: name).start(at: startSearchArray).getDocuments { [unowned self] querySnapshot, error in
            
            let arrayRecipeFirebaseModel = checkQuerySnapshotRecipeFromFirebase(querySnapshot: querySnapshot, error: error)
            
            if let arrayRecipeFirebaseModel = arrayRecipeFirebaseModel {
                searchResultArray = arrayRecipeFirebaseModel
                clousere(searchResultArray)
            }
        }
    }

}


extension FirebaseManager {
    
    private func convertFirebaseRecipeDataToRecipeFirebaseModel(documentID: String, data: [String : Any]) -> RecipeFirebaseModel {
        
        let publesherUserID = data["publesherUserID"] as? String ?? ""
        let name = data["name"] as? String ?? ""
        let nameForSearch = data["nameForSearch"] as? String ?? ""
        let imagePreviewURL = data["imagePreviewURL"] as? String ?? ""
        let imagesDescriptionURL = data["imagesDescriptionURL"] as? [String] ?? []
        let category = data["category"] as? String ?? ""
        let description = data["description"] as? String ?? ""
        let prepTime = data["prepTime"] as? String ?? ""
        let servings = data["servings"] as? Int
        let chill = data["chill"] as? String ?? ""
        let cookTime = data["cookTime"] as? String ?? ""
        let totalTime = data["totalTime"] as? String ?? ""
        let yield = data["yield"] as? Int
        let ingredients = data["ingredients"] as? [String] ?? []
        
        let calories = data["calories"] as? Int
        let saturatedFat = data["saturatedFat"] as? Int
        let totalFat = data["totalFat"] as? Int
        let cholesterol = data["cholesterol"] as? Int
        let sodium = data["sodium"] as? Int
        let totalCarbohydrate = data["totalCarbohydrate"] as? Int
        let dietaryFiber = data["dietaryFiber"] as? Int
        let totalSugars = data["totalSugars"] as? Int
        let protein = data["protein"] as? Int
        let metods = data["metods"] as? [String] ?? []
        
        return RecipeFirebaseModel(documentID: documentID, publesherUserID: publesherUserID, name: name, nameForSearch: nameForSearch, imagePreviewURL: imagePreviewURL, imagesDescriptionURL: imagesDescriptionURL, category: category, description: description, prepTime: prepTime, servings: servings, chill: chill, cookTime: cookTime, totalTime: totalTime, yield: yield, ingredients: ingredients, calories: calories, saturatedFat: saturatedFat, totalFat: totalFat, cholesterol: cholesterol, sodium: sodium, totalCarbohydrate: totalCarbohydrate, dietaryFiber: dietaryFiber, totalSugars: totalSugars, protein: protein, metods: metods)
    }
    
    private func checkQuerySnapshotRecipeFromFirebase(querySnapshot: QuerySnapshot?, error: Error?) -> [RecipeFirebaseModel]? {
        var arrayRecipeFirebaseModel: [RecipeFirebaseModel] = []
        
        if let error = error {
            alertTitle = "Error recive documents"
            alertMessage = error.localizedDescription
            showAlertSwitcher.toggle()
            return nil
        } else {
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let documentID = document.documentID
                    let recipeFirebaseModel = self.convertFirebaseRecipeDataToRecipeFirebaseModel(documentID: documentID, data: data)
                    
                    arrayRecipeFirebaseModel.append(recipeFirebaseModel)
                }
                return arrayRecipeFirebaseModel
            } else {
                alertTitle = "Error"
                alertMessage = "Can't extract querySnapshot from Firebase"
                showAlertSwitcher.toggle()
                return nil
            }
        }
    }
}

