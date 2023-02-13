//
//  RectangleCarouselCategoryView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 10.01.2023.
//

import SwiftUI

struct RectangleCarouselCategoryView: View {
    
    let isUserRecipe: Bool
    @ObservedObject var viewModel = RectangleCarouselCategoryViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                            firebaseManager.featchAndFilterRecipeFieldIsEqualTo(collectionName: "Recipe", field: "category", equalTo: category.rawValue)
                        }
                } label: {
                    RecipeCard2View(frameWidth: UIScreen.main.bounds.width - 10, frameMaxHeight: UIScreen.main.bounds.width / 1.3, iconFrameWidth: 90, iconFrameHeight: 90, recipeCard2ViewModel: viewModel.getRecipeCard2ViewModel(category: category))
                        .padding()
                }
            }
        }
        .background {
            Image("background-1")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

struct RectangleCarouselCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RectangleCarouselCategoryView(isUserRecipe: false)
                .environmentObject( { () -> FirebaseManager in
                    let firebaseManager = FirebaseManager()
                    firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                    return firebaseManager
                }() )
                .preferredColorScheme(.dark)
        }
    }
}
