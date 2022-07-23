//
//  ContentView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/19/22.
//

import SwiftUI

struct ContentView: View {
    
    let searchString = NSLocalizedString("ContentView.search", bundle: .main, value: "Search", comment: "")
    let bookmarkString = NSLocalizedString("ContentView.bookmark", bundle: .main, value: "Bookmarks", comment: "")
    @State private var selectedIndex = 0
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            SearchView()
                .tabItem {
                    Label(searchString, systemImage: "magnifyingglass")
                }
                .tag(0)
            BookmarkView()
                .tabItem {
                    Label(bookmarkString, systemImage: "bookmark")
                }
                .tag(1)
        }
        .accentColor(Color.ghGrayAccent)
        .onAppear {
            configureTabBarAppearance()
        }
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.ghBackground)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
