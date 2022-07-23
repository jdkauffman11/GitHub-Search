//
//  GitHubRepoSearchResponse.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/20/22.
//

import Foundation

struct GitHubRepoSearchResponse: Codable {
    var total_count: Float?
    var items: [RepositoryDescription]?
}
