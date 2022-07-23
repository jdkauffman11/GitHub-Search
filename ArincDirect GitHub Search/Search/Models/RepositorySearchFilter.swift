//
//  RepositorySearchFilter.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import Foundation

class RepositorySearchFilter: ObservableObject {
    var searchText: String?
    var resultsPerPage: Int?
    var language: String?
    var orderAscending: Bool?
    
    init(searchText: String? = "", resultsPerPage: Int? = 25, language: String? = "", orderAscending: Bool? = false) {
        self.searchText = searchText
        self.resultsPerPage = resultsPerPage
        self.language = language
        self.orderAscending = orderAscending
    }
}
