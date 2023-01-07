//
//  TemplateMainView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import SwiftUI

struct TemplateMainView: View {
    
    var titleView: String
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
                    RecipeCategoryCarouselView(nameCollection: $nameCollectionForCategoryView)
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
                    ListRecipeView(listRecipeViewModel: viewModel.createListRecipeViewModel(recipeFirebaseModel: searchedRecipe), searchText: .constant(""))
                }
            }
        }
    }
}

struct TemplateMainView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateMainView(titleView: "One Hundred New Recipe:", nameCollectionForCategoryView: .constant("Recipe"), searchTextFirebase: .constant(""), searchedRecipe: .constant([RecipeFirebaseModel.getFakeData()]))
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
//                 firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
            .preferredColorScheme(.dark)
    }
}
