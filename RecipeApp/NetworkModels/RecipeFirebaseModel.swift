//
//  RecipeFirebaseModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import Foundation

struct RecipeFirebaseModel: Identifiable, Codable {
    
    var id = UUID()
    var documentID: String
    var publesherUserID: String?
    var name: String
        var nameForSearch: String
        var imagePreviewURL: String?
        var imagesDescriptionURL: [String]?
        var category: String
        var description: String
        var prepTime: String
        var servings: Int?
        var chill: String
        var cookTime: String
        var totalTime: String
        var yield: Int?
        var ingredients: [String]
        
        var calories: Int?
        var saturatedFat: Int?
        var totalFat: Int?
        var cholesterol: Int?
        var sodium: Int?
        var totalCarbohydrate: Int?
        var dietaryFiber: Int?
        var totalSugars: Int?
        var prorein: Int?
        var metods: [String]
    
    static func getFakeData() -> RecipeFirebaseModel {
        RecipeFirebaseModel(documentID: "bvfwbhbih", publesherUserID: "fnerjnfjenjknier", name: "Cake",  nameForSearch: "cake", imagePreviewURL: nil,
                            imagesDescriptionURL: ["https://www.simplyrecipes.com/thmb/GOsUpfg8kJ6aCMqB6kdJnOK9lQg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2016__11__2016-12-06-SwissRoll-29-40a1c5c6b0cc4589bb6363156dc3ef44.jpg", "https://www.simplyrecipes.com/thmb/qWH09er2v40LHmthK8u0egN7yt4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-PieDough-LEAD-10-ceb8e647fb9d48be918d1d004dfefa57.jpg", "https://www.simplyrecipes.com/thmb/YYFnW0vPqylW6xUKlJjpThAjYm4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-PieDough-LEAD-7-84ecff9e88874da3a13aad297204e747.jpg"],
                            category: "ferge",
                            description: "hdfhew eh fhe rhe rhergn  wf vdhvwehnv bwi bv", prepTime: "10 min", servings: 2, chill: "22 min", cookTime: "12 min", totalTime: "44 min", yield: 1, ingredients: ["mevmj", "feirugn", "cnhenvuek", "ijnfie"], calories: 11, saturatedFat: 1, totalFat: 2, cholesterol: 3, sodium: 1, totalCarbohydrate: 3, dietaryFiber: 5, totalSugars: 1, prorein: 5, metods: ["vbwuihbv", "viuwnviu", "nuiewnvi", "nviunrw", "nhwnew"])
    }

}



//1. name - string
//2. nameForSearch - string lowCase
//3. image - string
//4. images - array string
//5. date - date
//6. category - string
//    1. description - string
//    2. prepTime - string
//    3. servings - int
//    4. chill -string
//    5. cookTime - string
//    6. totalTime - string
//    7. yield - int
//7. ingredients - array string
//8. nutrition -
//    1.  calories - int
//    2.  totalFat - int
//    3.  saturatedFat - int
//    4.  cholesterol - int
//    5.  sodium - int
//    6.  totalCarbohydrate - int
//    7.  dietaryFiber - int
//    8.  totalSugars - int
//    9.  protein - int
//9. metods - array string
