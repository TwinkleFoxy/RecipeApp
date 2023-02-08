//
//  AccountView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 14.01.2023.
//

import SwiftUI

struct AccountView: View {
    
    @Binding var signInSwitcher: Bool
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        if signInSwitcher {
            UserProfileView(signInSwitcher: $signInSwitcher)
                .environmentObject(firebaseManager)
        } else {
            SignUpView()
                .environmentObject(firebaseManager)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(signInSwitcher: .constant(false))
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
//                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
    }
}
