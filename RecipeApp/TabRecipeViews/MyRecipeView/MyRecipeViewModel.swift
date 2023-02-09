//
//  MyRecipeViewModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import Foundation

protocol MyRecipeViewModelProtocol {
    func searchRecipe(firebaseManager: FirebaseManager, searchText: String, limitToReceive: Int)
}

class MyRecipeViewModel: ObservableObject {
    
    @Published var userID: String = ""
    
    var timer: Timer?
    
    func getUserID(firebaseManager: FirebaseManager){
        guard let userID = firebaseManager.getCurrentUserIDFirebase() else { self.userID = ""; return }
        self.userID = userID
    }
    
    func searchRecipe(firebaseManager: FirebaseManager, searchText: String, limitToReceive: Int = 10000) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [unowned self] _ in
            firebaseManager.searchRecipeForMyRecipeViwe(searchText: searchText, inCollection: userID, limitToReceive: limitToReceive)
        }
    }
}
