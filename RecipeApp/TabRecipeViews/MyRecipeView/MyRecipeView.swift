//
//  MyRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import SwiftUI

struct MyRecipeView: View {
    
    let isUserRecipe: Bool = true
    @State private var viewModel = MyRecipeViewModel()
    @State private var searchTextFirebase: String = ""
    @Binding var signInSwitcher: Bool
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        if signInSwitcher {
            TemplateMainView(titleView: "Ten Thousand My Recipe:", isUserRecipe: isUserRecipe, nameCollectionForCategoryView: $viewModel.userID, searchTextFirebase: $searchTextFirebase, searchedRecipe: $firebaseManager.searchedRecipeForMyRecipe)
                .onAppear() {
                    viewModel.getUserID(firebaseManager: firebaseManager)
                    viewModel.searchRecipe(firebaseManager: firebaseManager, searchText: searchTextFirebase)
                }
                .onChange(of: searchTextFirebase) { newValue in
                    viewModel.searchRecipe(firebaseManager: firebaseManager, searchText: newValue)
                }
                .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher, actions: {}, message: {
                    Text(firebaseManager.alertMessage)
                })
        } else {
            SignUpView()
                .environmentObject(firebaseManager)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeView(signInSwitcher: .constant(true))
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
//                                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
//                firebaseManager.searchRecipeForMainTabView(searchText: "")
                return firebaseManager
            }() )
    }
}
