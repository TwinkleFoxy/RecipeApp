//
//  RecipeCard2ViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 01.01.2023.
//

import Foundation

protocol RecipeCard2ViewModelProtocol {
    var name: String { get }
    var localImage: String { get }
    var urlImage: URL? { get }
    init(recipeModel: RecipeCard2Model)
}

class RecipeCard2ViewModel: RecipeCard2ViewModelProtocol, ObservableObject {
    
    var name: String {
        recipeCard2Model.name
    }
    
    var localImage: String {
        if let localImage = recipeCard2Model.localImage {
            return localImage
        } else {
            return "no_image"
        }
    }
    
    var urlImage: URL? {
        if let urlStringImage = recipeCard2Model.urlStringImage {
         return URL(string: urlStringImage)
        } else {
            return nil
        }
    }
    
    private var recipeCard2Model: RecipeCard2Model
    
    required init(recipeModel: RecipeCard2Model) {
        self.recipeCard2Model = recipeModel
    }
}
