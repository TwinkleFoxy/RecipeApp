//
//  CustomTabBarModel.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 23.02.2023.
//

import Foundation
import SwiftUI

struct CustomTabBarModel: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let tab: Tab
}

let tabItems = [
    CustomTabBarModel(name: "Home", icon: "house", tab: .home),
    CustomTabBarModel(name: "Category", icon: "list.bullet", tab: .category),
    CustomTabBarModel(name: "Favourite", icon: "star", tab: .favourite),
    CustomTabBarModel(name: "My Recipe", icon: "leaf", tab: .myRecipe),
    CustomTabBarModel(name: "Account", icon: "person", tab: .account)
]

enum Tab: String {
    case home
    case category
    case favourite
    case myRecipe
    case account
}

struct CustomTabViewGeometryReader: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
