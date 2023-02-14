//
//  MainView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 03.01.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var animate = 1.0
    @ObservedObject var firebaseManager = FirebaseManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView {
                    
                    // Home View
                    HomeView()
                        .padding(.leading, 9)
                        .padding(.top, 5)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(1)
                        .background {
                            Image("background-1")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        .environmentObject(firebaseManager)
                    
                    
                    // Category List View
                    RectangleCarouselCategoryView(isUserRecipe: false)
                        .padding(.leading, 9)
                        .padding(.top, 5)
                        .tabItem {
                            Label("Category", systemImage: "list.bullet")
                        }
                        .tag(2)
                        .background {
                            Image("background-1")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        .environmentObject(firebaseManager)
                    
                    
                    // Favourite View
//                    VStack() {
//                        Text("Favourite Recipe")
//                            .font(.title2)
//                            .bold()
//                            .foregroundColor(.white.opacity(0.7))
//                            .padding(.top, 2)
//                    }
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                    .tabItem {
//                        Label("Favourite", systemImage: "star")
//                    }
//                    .tag(3)
//                    .background {
//                        Image("background-1")
//                            .resizable()
//                            .ignoresSafeArea()
//                    }
                    
                    // Self Saved Recipe View
                    MyRecipeView(signInSwitcher: $firebaseManager.signInSwitcher)
                        .padding(.leading, 9)
                        .padding(.top, 92)
                        .tabItem {
                            Label("My Recipe", systemImage: "leaf")
                        }
                        .tag(4)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .background {
                            Image("background-1")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        .environmentObject(firebaseManager)
                    
                    // Account View
                    AccountView(signInSwitcher: $firebaseManager.signInSwitcher)
                        .tabItem {
                            Label("Account", systemImage: "person")
                        }
                        .tag(5)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .background {
                            Image("background-1")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        .environmentObject(firebaseManager)
                }
                .animation(.easeInOut(duration: 2), value: animate)
                .transition(.slide)
                .onAppear() {
                    firebaseManager.addStateDidChangeListenerFirebase()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject( { () -> FirebaseManager in
                let firebaseManager = FirebaseManager()
                //                firebaseManager.featchPublicRecipeWithMaxLimit(limit: 10)
                return firebaseManager
            }() )
            .preferredColorScheme(.dark)
    }
}
