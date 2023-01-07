//
//  RecipeCategoryCarouselViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation

protocol RecipeCategoryCarouselViewModelProtocol {
    func getRecipeCard2ViewModel(category: CategoryRecipe) -> RecipeCard2ViewModel
    func getCategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> CategoryListRecipeViewModel
    func getRecipefromFirebase(firebaseManager: FirebaseManager, collectionName: String, categoryRecipe: CategoryRecipe)
}

class RecipeCategoryCarouselViewModel: RecipeCategoryCarouselViewModelProtocol, ObservableObject {
    func getRecipeCard2ViewModel(category: CategoryRecipe) -> RecipeCard2ViewModel {
        RecipeCard2ViewModel(recipeModel: RecipeCard2Model(name: category.rawValue, localImage: category.rawValue, urlStringImage: nil))
    }
    
    func getCategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> CategoryListRecipeViewModel {
        CategoryListRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel)
    }
    
    func getRecipefromFirebase(firebaseManager: FirebaseManager, collectionName: String, categoryRecipe: CategoryRecipe) {
        firebaseManager.featchAndFilterRecipeFieldIsEqualTo(collectionName: collectionName, field: "category", equalTo: categoryRecipe.rawValue)
    }
}
