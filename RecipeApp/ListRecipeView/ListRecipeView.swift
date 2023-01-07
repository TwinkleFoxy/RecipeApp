//
//  ListRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import SwiftUI

struct ListRecipeView: View {
    
    @ObservedObject var listRecipeViewModel: ListRecipeViewModel
    @Binding var searchText: String
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(listRecipeViewModel.searchResults, id: \.id) { recipeFirebaseModel in
                        NavigationLink {
                            DetailRecipeView(viewModel: listRecipeViewModel.getDetailRecipeViewModel(recipeFirebaseModel: recipeFirebaseModel))
                        } label: {
                            RecipeCard2View(frameWidth: (geometry.size.width / 2) - 16, frameMaxHeight: ((geometry.size.width / 2) - 16) / 1.3, iconFrameWidth: 44, iconFrameHeight: 44, recipeCard2ViewModel: listRecipeViewModel.getRecipeCard2ViewModel(recipeFirebaseModel: recipeFirebaseModel))
                                .padding(.vertical)
                        }
                    }
                }
            }
        }
        .onChange(of: searchText) { newValue in
            listRecipeViewModel.searchText = newValue
        }
    }
}


struct ListRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListRecipeView(listRecipeViewModel: ListRecipeViewModel(recipeFirebaseModel: [RecipeFirebaseModel.getFakeData()]), searchText: .constant(""))
                .preferredColorScheme(.dark)
        }
    }
}
