//
//  CategoryListRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import SwiftUI

struct CategoryListRecipeView: View {
    
    let isUserRecipe: Bool
    @State var searchText: String = ""
    @ObservedObject var categoryListRecipeViewModel: CategoryListRecipeViewModel
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        VStack(spacing: 5) {
            TextFieldWithGlowIconView(iconName: "magnifyingglass", textPlaceHolder: "Search", text: $searchText)
            ListRecipeView(isUserRecipe: isUserRecipe, listRecipeViewModel: categoryListRecipeViewModel.getListRecipeViewModel(), searchText: $searchText)
                .environmentObject(firebaseManager)
        }
        .padding(.horizontal, 5)
        .padding(.top, 5)
    }
}

struct CategoryListRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListRecipeView(isUserRecipe: true, categoryListRecipeViewModel: CategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel.getFakeData()]))
            .environmentObject( { () -> FirebaseManager in
                            let firebaseManager = FirebaseManager()
            //                 firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                            return firebaseManager
                        }() )
            .preferredColorScheme(.dark)
    }
}
