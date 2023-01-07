//
//  HomeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 05.01.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    func searchRecipe(firebaseManager: FirebaseManager, searchText: String, limitToReceive: Int)
}

class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    
    var timer: Timer?
    
    func searchRecipe(firebaseManager: FirebaseManager, searchText: String, limitToReceive: Int = 1000) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            firebaseManager.searchRecipeForHomeView(searchText: searchText, limitToReceive: limitToReceive)
        }
    }
}
