//
//  DetailRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import SwiftUI

struct DetailRecipeView: View {
    
    let isUserRecipe: Bool
    @State private var selectedPage = 0
    @ObservedObject var viewModel: DetailRecipeViewModel
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @Environment (\.presentationMode) var presentationMode
    
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
                    
                    // Favourite / Trash  Button
                    TopRightButtonView(isUserRecipe: isUserRecipe, foregroundFavouriteButton: firebaseManager.userFavouriteRecipeDocument[viewModel.documentID]) {
                        viewModel.topRightButtonPressed(isUserRecipe: isUserRecipe, firebaseManager: firebaseManager, documentID: viewModel.documentID, presentationMode: presentationMode)
                    }
                    .frame(width: 35, height: 35)
                    .padding(10)
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
        .alert(firebaseManager.alertTitle, isPresented: $firebaseManager.showAlertSwitcher, actions: {}, message: {
            Text(firebaseManager.alertMessage) // Alert for error at firebase
        })
        .alert(viewModel.alertTitleAuth, isPresented: $viewModel.showAlertSwitcherAuth, actions: {}, message: {
            Text(viewModel.alertMessageAuth) // Alert for error at viewModel then user not authorized
        })
        .alert(viewModel.alertTitleConfirmDeleteUserRecipe, isPresented: $viewModel.showAlertSwitcherConfirmDeleteUserRecipe) {
            Button(role: .cancel, action: {}, label: { Text("Cancel") })
            Button(role: .destructive, action: {
                viewModel.confirmedDeleteRecipeFromAllert(firebaseManager: firebaseManager, presentationMode: presentationMode)
            }, label: { Text("Delete") } )
        } message: {
            Text(viewModel.alertMessageConfirmDeleteUserRecipe)
        } // Alert for confirm the user's desire to delete the recipe
    }
}

struct DetailRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailRecipeViewModel(recipeFirebaseModel: RecipeFirebaseModel.getFakeData())
        DetailRecipeView(isUserRecipe: true, viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}



private struct TopRightButtonView: View {
    
    let isUserRecipe: Bool
    var foregroundFavouriteButton: Bool?
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            if isUserRecipe {
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .foregroundColor(.pink_gradient_1)
                    .opacity(0.75)
            } else {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(foregroundFavouriteButton ?? false ? .pink : .pink_gradient_1)
            }
        }
        .frame(width: 35, height: 35)
        .padding(10)
    }
}
