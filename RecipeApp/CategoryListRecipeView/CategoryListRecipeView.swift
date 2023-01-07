//
//  CategoryListRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import SwiftUI

struct CategoryListRecipeView: View {
    
    @State var searchText: String = ""
    @ObservedObject var categoryListRecipeViewModel: CategoryListRecipeViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            TextFieldWithGlowIconView(iconName: "magnifyingglass", textPlaceHolder: "Search", text: $searchText)
            ListRecipeView(listRecipeViewModel: categoryListRecipeViewModel.getListRecipeViewModel(), searchText: $searchText)
        }
        .padding(.horizontal, 5)
        .padding(.top, 5)
    }
}

struct CategoryListRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListRecipeView(categoryListRecipeViewModel: CategoryListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel.getFakeData()]))
            .preferredColorScheme(.dark)
    }
}
