//
//  TemplateMainViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 05.01.2023.
//

import Foundation

protocol TemplateMainViewModelProtocol {
    func createListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> ListRecipeViewModel
    func createRecipeCategoryCarouselViewModel(forCategiryRecipeFirebaseModel: [RecipeFirebaseModel]) -> RecipeCategoryCarouselViewModel
}

class TemplateMainViewModel: TemplateMainViewModelProtocol, ObservableObject {
    func createListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel]) -> ListRecipeViewModel {
        return ListRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel)
    }
    
    func createRecipeCategoryCarouselViewModel(forCategiryRecipeFirebaseModel: [RecipeFirebaseModel]) -> RecipeCategoryCarouselViewModel {
        return RecipeCategoryCarouselViewModel()
    }
}
