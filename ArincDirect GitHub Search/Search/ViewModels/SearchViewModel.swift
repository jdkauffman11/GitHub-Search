//
//  SearchViewModel.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/19/22.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    private var task: AnyCancellable?
    @Published var searchResult = GitHubRepoSearchResponse()
    @Published var searchError: GHSError? = nil
    
    func fetchRepos(searchFilters: RepositorySearchFilter) {
        let languageSearchString = !(searchFilters.language?.isEmpty ?? true) ? "+language:\(searchFilters.language?.uppercased() ?? "")" : ""
        guard let searchText = searchFilters.searchText,
              let sortAscending = searchFilters.orderAscending,
              let resultsPerPage = searchFilters.resultsPerPage,
              let url = URL(string: "https://api.github.com/search/repositories?q=\(searchText)+in:name,description,readme\(languageSearchString)&per_page=\(resultsPerPage)&sort=stars&order=\(sortAscending ? "asc" : "desc")") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": ""]
        task = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: GitHubRepoSearchResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        print("Error \(error)")
                        self?.searchError = GHSError(error: .networkingError)
                    case .finished: print("Success")
                    }
                },
                receiveValue: { [weak self] in self?.searchResult = $0 }
            )
    }
}
