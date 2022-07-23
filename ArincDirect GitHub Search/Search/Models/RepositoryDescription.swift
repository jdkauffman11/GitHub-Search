//
//  RepositoryDescription.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/20/22.
//

import Foundation

struct RepositoryDescription: Codable, Hashable {
    var name: String?
    var description: String?
    var language: String?
    var stargazers_count: Float?
}
