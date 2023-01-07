//
//  CategoryListRecipeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation

protocol CategoryListRecipeViewModelProtocol {
    func getListRecipeViewModel() -> ListRecipeViewModel
}

class CategoryListRecipeViewModel: CategoryListRecipeViewModelProtocol, ObservableObject {
    
    func getListRecipeViewModel() -> ListRecipeViewModel {
        ListRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel)
    }
    
    var recipeFirebaseModel: [RecipeFirebaseModel]
    
    init(recipeFirebaseModel: [RecipeFirebaseModel]) {
        self.recipeFirebaseModel = recipeFirebaseModel
    }
}
