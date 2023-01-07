//
//  MiniDetailsRecipeModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import Foundation

struct AboutRecipeModel {
    var timePrep: String
    var timeChill: String
    var servings: String //Int
    var timeCook: String
    var timeTotal: String
    var yield: String //Int
    var dishDescription: String
}

struct NutritionRecipeModel {
    var calories: String //Int
    var totalFat: String //Int
    var saturatedFat: String //Int
    var cholesterol: String //Int
    var sodium: String //Int
    var totalCarbohydrate: String //Int
    var dietaryFiber: String //Int
    var totalSugars: String //Int
    var protein: String //Int
}
