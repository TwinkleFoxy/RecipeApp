//
//  TemplateMainView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import SwiftUI

struct TemplateMainView: View {
    
    var titleView: String
    let isUserRecipe: Bool
    @Binding var nameCollectionForCategoryView: String
    @Binding var searchTextFirebase: String
    @Binding var searchedRecipe: [RecipeFirebaseModel]
    @ObservedObject var viewModel = TemplateMainViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        HStack {
            VStack() {
                VStack(alignment: .leading, spacing: 9) {
                    Text("Food Categories:")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white.opacity(0.7))
                    RecipeCategoryCarouselView(isUserRecipe: isUserRecipe, nameCollection: $nameCollectionForCategoryView)
                        .padding(.horizontal, 5)
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading, spacing: 8) {
                    Text(titleView)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white.opacity(0.7))
                    TextFieldWithGlowIconView(iconName: "magnifyingglass", textPlaceHolder: "Search", text: $searchTextFirebase)
                        .padding(.horizontal , 5)
                    ListRecipeView(isUserRecipe: isUserRecipe, listRecipeViewModel: viewModel.createListRecipeViewModel(recipeFirebaseModel: searchedRecipe), searchText: .constant(""))
                        .environmentObject(firebaseManager)
                }
            }
        }
    }
}

struct TemplateMainView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateMainView(titleView: "One Hundred New Recipe:", isUserRecipe: true, nameCollectionForCategoryView: .constant("Recipe"), searchTextFirebase: .constant(""), searchedRecipe: .constant([RecipeFirebaseModel.getFakeData()]))
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
//                 firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
            .preferredColorScheme(.dark)
    }
}
