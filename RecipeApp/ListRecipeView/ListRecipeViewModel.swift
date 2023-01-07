//
//  ListRecipeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation

protocol ListRecipeViewModelProtocol {
    func getRecipeCard2ViewModel(recipeFirebaseModel: RecipeFirebaseModel) -> RecipeCard2ViewModel
    func getDetailRecipeViewModel(recipeFirebaseModel: RecipeFirebaseModel) -> DetailRecipeViewModel
    var searchResults: [RecipeFirebaseModel] { get }
    init(recipeFirebaseModel: [RecipeFirebaseModel])
}

class ListRecipeViewModel: ListRecipeViewModelProtocol, ObservableObject {
    
    func getRecipeCard2ViewModel(recipeFirebaseModel: RecipeFirebaseModel) -> RecipeCard2ViewModel {
        return RecipeCard2ViewModel(recipeModel: RecipeCard2Model(name: recipeFirebaseModel.name, localImage: nil, urlStringImage: recipeFirebaseModel.imagePreviewURL))
    }
    
    func getDetailRecipeViewModel(recipeFirebaseModel: RecipeFirebaseModel) -> DetailRecipeViewModel {
        return DetailRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel)
    }
    
    var searchResults: [RecipeFirebaseModel] {
        if searchText.isEmpty {
            return recipeFirebaseModel
        } else {
            return recipeFirebaseModel.filter{$0.nameForSearch.contains(searchText.lowercased())}
        }
    }
    
    private let recipeFirebaseModel: [RecipeFirebaseModel]
    
    var searchText: String = ""
    
    required init(recipeFirebaseModel: [RecipeFirebaseModel]) {
        self.recipeFirebaseModel = recipeFirebaseModel
    }
}
