//
//  MiniDetailsRecipeView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 04.01.2023.
//

import SwiftUI

struct AboutRecipeView: View {
    let aboutRecipeModel: AboutRecipeModel
    var body: some View {
        ScrollView {
            Text("About")
                .font(.title2.bold())
                .padding(.top)
            VStack(alignment: .leading) {
                HStack() {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Prep: \(aboutRecipeModel.timePrep)")
                        Text("Chill: \(aboutRecipeModel.timeChill)")
                        Text("Cook: \(aboutRecipeModel.timeCook)")
                        
                    }
                    .padding(10)
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Yield: \(aboutRecipeModel.yield)")
                        Text("Servings: \(aboutRecipeModel.servings)")
                        Text("Total: \(aboutRecipeModel.timeTotal)")
                    }
                    .padding(10)
                }
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white, style: .init(lineWidth: 0.8, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [10, 10], dashPhase: 1))
                }
                .padding(.bottom, 10)
                Text(aboutRecipeModel.dishDescription)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct AboutRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutRecipeView(aboutRecipeModel: AboutRecipeModel(timePrep: "10 mins", timeChill: "15 mins", servings: "2", timeCook: "25 mins", timeTotal: "50 mins", yield: "2", dishDescription: "Dmvjds mkemfk mewkfek ejfejfoi fgshfdh f sghfgdfgh shfghsfg"))
            .preferredColorScheme(.dark)
    }
}


struct IngredientsRecipeView: View {
    let imageName: String
    let ingredientsArray: [String]
    var body: some View {
        ScrollView {
            Text("Ingredients")
                .font(.title2.bold())
                .padding(.top)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(ingredientsArray, id: \.self) { ingredient in
                        HStack(alignment: .top) {
                            Image(systemName: imageName)
                            Text("\(ingredient)")
                        }
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct IngredientsRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsRecipeView(imageName: "circle", ingredientsArray: ["Kkoo", "Pojijoi", "Muhbu"])
            .preferredColorScheme(.dark)
    }
}

struct NutritionRecipeView: View {
    let nutritions: NutritionRecipeModel
    var body: some View {
        ScrollView {
            Text("Nutrition")
                .font(.title2.bold())
                .padding(.top)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Calories: \(nutritions.calories)")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Total Fat: \(nutritions.totalFat)")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle")
                            Text("Saturated Fat: \(nutritions.saturatedFat)")
                                .font(.subheadline)
                                .opacity(0.7)
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Cholesterol: \(nutritions.cholesterol)")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Sodium: \(nutritions.sodium)")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Total Carbohydrate: \(nutritions.totalCarbohydrate)")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle")
                            Text("Dietary Fiber: \(nutritions.dietaryFiber)")
                                .font(.subheadline)
                                .opacity(0.7)
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle")
                            Text("Total Sugars: \(nutritions.totalSugars)")
                                .font(.subheadline)
                                .opacity(0.7)
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                            Text("Protein: \(nutritions.protein)")
                        }
                    }
                    .foregroundColor(.white.opacity(0.9))
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct NutritionRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionRecipeView(nutritions: NutritionRecipeModel(calories: "122",
                                                                        totalFat: "133 g",
                                                                        saturatedFat: "123 g",
                                                                        cholesterol: "321 mg",
                                                                        sodium: "423 mg",
                                                                        totalCarbohydrate: "444 g",
                                                                        dietaryFiber: "12 g",
                                                                        totalSugars: "232 g",
                                                                        protein: "123 g"))
            .preferredColorScheme(.dark)
    }
}


struct MethodRecipeView: View {
    let imageName: String
    let instructions_metods: [String]
    var body: some View {
        ScrollView {
            Text("Method")
                .font(.title2.bold())
                .padding(.top)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(instructions_metods.indices, id: \.self) { index in
                        HStack(alignment: .top) {
                            Image(systemName: "\(index + 1).circle")
                            Text(instructions_metods[index])
                        }
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct MethodsRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        MethodRecipeView(imageName: "circle", instructions_metods: ["Kkoonjk njknjk njnj njk   njnj jnjk  jj kj  j jnjkijklk njkkm  injk njknjknk jk j njn  njnjk  njnjkn  njnjknkj jnjk", "Pojijoi njknkj jnjknk jnnijn jnijmjn ijygg v vtfygbg ftftgu gtybg ", "Muhbu"])
            .preferredColorScheme(.dark)
    }
}
