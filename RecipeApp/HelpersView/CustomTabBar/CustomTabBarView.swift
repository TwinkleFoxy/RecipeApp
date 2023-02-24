//
//  CustomTabBarView.swift
//  RecipeApp
//
//  Created by Алексей Однолько on 23.02.2023.
//

import SwiftUI

import SwiftUI

struct CustomTabBarView: View {
    
    @State private var widthTabItem: CGFloat = 0
    @Binding var selectedTab: Tab
    let backlightColor: Color
    
    var body: some View {
        HStack {
            ForEach(tabItems) { item in // Tab bar buttons
                TabBarButton(currantItem: item, selectedTab: $selectedTab, widthTabItem: $widthTabItem)
            }
        }
        .padding(.top, 15)
        .frame(height: 88, alignment: .top)
        .background { // Stroke and Blur
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.2))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 4, y: 5)
        }
        .cornerRadius(30)
        .background { // Background lighting circle
            BacklightView(selectedTab: $selectedTab, padingEdge: .horizontal, padingNumber: 8, view: Circle()
                .fill(backlightColor)
                .frame(width: widthTabItem))
        }
        .overlay{ // Rectangle dash
            BacklightView(selectedTab: $selectedTab, padingEdge: .top, padingNumber: 3, view: RoundedRectangle(cornerRadius: 30)
                .fill(backlightColor)
                .frame(width: 30, height: 3, alignment: .top)
                .frame(width: widthTabItem)
                .frame(maxHeight: .infinity, alignment: .top)
            )
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}


private struct BacklightView<T: View>: View {
    
    @Binding var selectedTab: Tab
    let padingEdge: Edge.Set
    let padingNumber: CGFloat
    let view: T
    
    var body: some View {
        HStack {
            if selectedTab == .category { Spacer() }
            if selectedTab == .favourite { Spacer(); Spacer() }
            if selectedTab == .myRecipe { Spacer(); Spacer(); Spacer() }
            if selectedTab == .account { Spacer() }
            view
            if selectedTab == .home { Spacer() }
            if selectedTab == .category { Spacer(); Spacer(); Spacer() }
            if selectedTab == .favourite { Spacer(); Spacer() }
            if selectedTab == .myRecipe { Spacer() }
        }
        .padding(padingEdge, padingNumber)
    }
}

private struct TabBarButton: View {
    
    let currantItem: CustomTabBarModel
    @Binding var selectedTab: Tab
    @Binding var widthTabItem: CGFloat
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.65, dampingFraction: 0.75, blendDuration: 0.5)) {
                selectedTab = currantItem.tab
            }
        } label: {
            VStack(spacing: 0) {
                Image(systemName: currantItem.icon)
                    .symbolVariant(.fill)
                    .frame(width: 44, height: 30)
                Text(currantItem.name)
                    .font(.caption)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(selectedTab == currantItem.tab ? .primary : .secondary)
        .blendMode(selectedTab == currantItem.tab ? .overlay : .normal)
        .overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: CustomTabViewGeometryReader.self, value: proxy.size.width)
            }
        }
        .onPreferenceChange(CustomTabViewGeometryReader.self, perform: { value in
            widthTabItem = value
        })
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTabBarView(selectedTab: .constant(.home), backlightColor: .pink)
        }
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.portrait)
    }
}
