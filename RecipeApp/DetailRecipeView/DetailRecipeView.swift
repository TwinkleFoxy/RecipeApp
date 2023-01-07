//
//  DetailRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import SwiftUI

struct DetailRecipeView: View {
    
    @State private var selectedPage = 0
    @ObservedObject var viewModel: DetailRecipeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .topTrailing) {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .stroke()
                    
                    TabView {
                        ForEach(viewModel.imagesURL, id: \.self) { imageURL in
                            AsyncImage(url: URL(string: imageURL), scale: 2) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    // Favourite Button
//                    Button {
//
//                    } label: {
//                        Image(systemName: "star.fill")
//                            .resizable()
//                            .foregroundColor(.pink_gradient_1)
//                    }
//                    .frame(width: 35, height: 35)
//                    .padding(10)
                    
                }
                .cornerRadius(15)
                .padding(.horizontal)
                .frame(height: geometry.size.height / 3)
                
                ZStack() {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white.opacity(0.7))
                        .frame(height: 45)
                        .background {
                            Color.secondaryBackground.opacity(0.5)
                        }
                        .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                        .cornerRadius(15)
                    Text(viewModel.name)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .opacity(0.97)
                        .frame(height: 45)
                        .padding(.horizontal, 5)
                }
                .padding(.top)
                .padding(.horizontal)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white.opacity(0.7))
                        .background {
                            Color.secondaryBackground.opacity(0.5)
                        }
                        .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                        .cornerRadius(15)
                    
                    TabView(selection: $selectedPage) {
                        AboutRecipeView(aboutRecipeModel: viewModel.aboutRecipeModel)
                            .tag(0)
                        
                        IngredientsRecipeView(imageName: "circle", ingredientsArray: viewModel.ingredients)
                            .tag(1)
                        
                        NutritionRecipeView(nutritions: viewModel.nutritionRecipeModel)
                            .tag(2)
                        
                        MethodRecipeView(imageName: "circle", instructions_metods: viewModel.metods)
                            .tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                    .background {
                        
                    }
                }
                .cornerRadius(15)
                .padding()
            }
        }
        .background {
            Image("background-2")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

struct DetailRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailRecipeViewModel(recipeFirebaseModel: RecipeFirebaseModel.getFakeData())
        DetailRecipeView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}

