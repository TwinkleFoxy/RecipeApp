//
//  RecipeCategoryCarouselView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import SwiftUI

struct RecipeCategoryCarouselView: View {
    
    let isUserRecipe: Bool
    @Binding var nameCollection: String
    @ObservedObject var viewModel = RecipeCategoryCarouselViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(CategoryRecipe.allCases, id: \.rawValue) { category in
                    NavigationLink {
                        CategoryListRecipeView(isUserRecipe: isUserRecipe, categoryListRecipeViewModel: viewModel.getCategoryListRecipeViewModel(recipeFirebaseModel: firebaseManager.filteredRecipe))
                            .environmentObject(firebaseManager)
                            .background {
                                Image("background-1")
                                    .resizable()
                                    .ignoresSafeArea()
                            }
                            .onAppear {
                                viewModel.getRecipefromFirebase(firebaseManager: firebaseManager, collectionName: nameCollection, categoryRecipe: category)
                            }
                    } label: {
                            RecipeCard2View(frameWidth: 132, frameMaxHeight: 100, iconFrameWidth: 66, iconFrameHeight: 66, recipeCard2ViewModel: viewModel.getRecipeCard2ViewModel(category: category))
                    }
                }
            }.frame(height: 172)
        }
    }
}

struct RecipeCategoryCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeCategoryCarouselView(isUserRecipe: false, nameCollection: .constant("Recipe"))
                .environmentObject( { () -> FirebaseManager in
                    let firebaseManager = FirebaseManager()
                    //firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                    return firebaseManager
                }() )
                .preferredColorScheme(.dark)
        }
    }
}

