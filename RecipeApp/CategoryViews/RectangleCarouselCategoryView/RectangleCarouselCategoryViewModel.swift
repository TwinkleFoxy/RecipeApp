//
//  RectangleCarouselCategoryViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 10.01.2023.
//

import Foundation

protocol RectangleCarouselCategoryViewModelprotocol {
    func getRecipeCard2ViewModel(category: CategoryRecipe) -> RecipeCard2ViewModel
    func getCategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> CategoryListRecipeViewModel
}

class RectangleCarouselCategoryViewModel: RectangleCarouselCategoryViewModelprotocol, ObservableObject {
    func getRecipeCard2ViewModel(category: CategoryRecipe) -> RecipeCard2ViewModel {
        RecipeCard2ViewModel(recipeModel: RecipeCard2Model(name: category.rawValue, localImage: category.rawValue, urlStringImage: nil))
    }
    
    func getCategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> CategoryListRecipeViewModel {
        CategoryListRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel)
    }
}
