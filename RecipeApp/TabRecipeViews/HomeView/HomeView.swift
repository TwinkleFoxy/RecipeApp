//
//  HomeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 05.01.2023.
//

import SwiftUI

struct HomeView: View {
    
    let isUserRecipe: Bool = false
    @State private var viewModel = HomeViewModel()
    @State private var searchTextFirebase: String = ""
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        TemplateMainView(titleView: "One Thousand New Recipe:", isUserRecipe: isUserRecipe, nameCollectionForCategoryView: .constant("Recipe"), searchTextFirebase: $searchTextFirebase, searchedRecipe: $firebaseManager.searchedRecipeForHomeView)
            .onAppear() {
                viewModel.searchRecipe(firebaseManager: firebaseManager, searchText: searchTextFirebase)
            }
            .onChange(of: searchTextFirebase) { newValue in
                viewModel.searchRecipe(firebaseManager: firebaseManager, searchText: newValue)
            }
            .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher, actions: {}, message: {
                Text(firebaseManager.alertMessage)
            })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
                //                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
    }
}
