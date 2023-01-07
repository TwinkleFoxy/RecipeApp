//
//  RecipeCard2View.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 01.01.2023.
//

import SwiftUI

struct RecipeCard2View: View {
    let frameWidth: CGFloat
    let frameMaxHeight: CGFloat
    let iconFrameWidth: CGFloat
    let iconFrameHeight: CGFloat
    
    @ObservedObject var recipeCard2ViewModel: RecipeCard2ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if (recipeCard2ViewModel.urlImage == nil) {
                Image(recipeCard2ViewModel.localImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .frame(width: iconFrameWidth, height: iconFrameHeight)
                    .opacity(0.75)
            } else {
                AsyncImage(url: recipeCard2ViewModel.urlImage, scale: 2) { image in
                    image
                        .frame(width: iconFrameWidth, height: iconFrameHeight)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .opacity(0.75)
                } placeholder: {
                    ProgressView()
                }
            }
            ZStack {
                Text(recipeCard2ViewModel.name)
                    .font(.title2)
                    .padding(.horizontal, 3)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 4, y: 8)
                    .foregroundColor(.white.opacity(0.7))
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white.opacity(0.1))
            }
            .frame(height: 50)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.7))
                .background(Color.secondaryBackground.opacity(0.5))
                .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                .shadow(color: .black.opacity(0.8), radius: 10, x: 4, y: 5)
        }
        .cornerRadius(30)
        .frame(maxHeight: frameMaxHeight)
        .frame(width: frameWidth)
    }
}

struct RecipeCard2View_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard2View(frameWidth: 90, frameMaxHeight: 120, iconFrameWidth: 44, iconFrameHeight: 44, recipeCard2ViewModel: RecipeCard2ViewModel(recipeModel: RecipeCard2Model(name: "Cake", localImage: "Breakfast", urlStringImage: nil)))
            .preferredColorScheme(.dark)
    }
}
