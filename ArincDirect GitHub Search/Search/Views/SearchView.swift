//
//  SearchView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/19/22.
//

import SwiftUI
import Combine

struct SearchView: View {
    private let repositoryTitle = NSLocalizedString("SearchView.searchTitle",
                                                    bundle: .main,
                                                    value: "Repository search",
                                                    comment: "View title")
    private let searchPlaceholder = NSLocalizedString("SearchView.searchPlaceholder",
                                                      bundle: .main,
                                                      value: "Type a repository name, description or 'README'",
                                                      comment: "search field placeholder notifying user of searchable content")
    private let submitText = NSLocalizedString("SearchView.submitText",
                                               bundle: .main,
                                               value: "submit",
                                               comment: "")
    private let alertTitle = NSLocalizedString("SearchView.alertTitle", bundle: .main, value: "Oh no!", comment: "")
    private let tryAgain = NSLocalizedString("SearchView.tryAgain", bundle: .main, value: "Try again", comment: "")
    @ObservedObject private var filters = RepositorySearchFilter()
    @ObservedObject private var searchViewModel = SearchViewModel()
    @State private var searchContents = ""
    @State private var showError = false
    @State private var showingFilters = false
    init() {
        configureNavBar()
        filters.searchText = searchContents
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            ResultCountView(showingResultCount: searchViewModel.searchResult.items?.count, totalResultCount: searchViewModel.searchResult.total_count)
                                .padding(.vertical, 8)
                            Spacer()
                            Button(action: {
                                showingFilters = true
                            }) {
                                Image(systemName: "line.3.horizontal")
                            }
                            .padding(.trailing, 16)
                        }
                        RepositoryListView(repositories: searchViewModel.searchResult.items)
                    }
                    Button(submitText) {
                        searchRepos()
                    }
                    .font(.headline)
                }
                .navigationTitle(repositoryTitle)
                .background(Color.ghBackground)
                .onTapGesture {
                    endTextEditing()
                    showingFilters = false
                }
                .alert(item: $searchViewModel.searchError) { _ in
                    Alert(title: Text(alertTitle),
                          message: Text(searchViewModel.searchError!.error.description),
                          primaryButton: .default(Text(tryAgain), action: { searchRepos() }),
                          secondaryButton: .cancel())
                }
                if showingFilters {
                    SearchFilterView(filterModel: filters)
                        .padding()
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.ghGrayAccent)
        .foregroundColor(Color.ghGrayAccent)
        .searchable(text: $searchContents, prompt: searchPlaceholder)
        .font(Font.system(size: 13))
        .onSubmit(of: .search) {
            searchRepos()
        }
    }
    
    func searchRepos() {
//        searchViewModel.fetchRepos(searchText: searchContents)
        showingFilters = false
        endTextEditing()
        filters.searchText = searchContents
        searchViewModel.fetchRepos(searchFilters: filters)

    }
    
    func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(Color.ghGrayAccent)]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(Color.ghGrayAccent)]
        navBarAppearance.backgroundColor = UIColor(Color.ghBackground)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
