//
//  CategoryRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 08.02.2023.
//

import SwiftUI

struct CategoryRecipeView: View {
    
    var placeHolder: String
    @State private var isExpanded: Bool = false
    @Binding var selectedCategory: CategoryRecipe?
    
    var body: some View {
        DisclosureGroup(selectedCategory?.rawValue ?? placeHolder,
                    isExpanded: $isExpanded) {
            ScrollView {
                ForEach(CategoryRecipe.allCases, id: \.rawValue) { selectedCategory in
                    Text(selectedCategory.rawValue)
                        .padding()
                        .onTapGesture {
                            self.selectedCategory = selectedCategory
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 30)
                }
            }
            .frame(maxHeight: CGFloat(CategoryRecipe.allCases.count) * 25)
        }
        .tint(.black.opacity(0.7))
        .foregroundColor(.white.opacity(0.7))
        .cornerRadius(15)
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 12)
        .background{
            RoundedRectangle(cornerRadius: 15)
                .stroke()
                .opacity(0.2)
            Color.secondaryBackground
                .opacity(0.8)
                .cornerRadius(15)
        }
    }
}



struct CategoryRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRecipeView(placeHolder: "Category Recipe (Scrollable)", selectedCategory: .constant(nil))
            .preferredColorScheme(.light)
    }
}
