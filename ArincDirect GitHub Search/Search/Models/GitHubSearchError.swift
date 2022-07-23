//
//  GitHubSearchError.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import Foundation

enum GitHubSearchError: Error, LocalizedError {
    case networkingError
    
    var description: String {
        switch self {
        case .networkingError:
            return NSLocalizedString("GitHubSearchError.networkingError", bundle: .main, value: "There was a problem retrieving data. Please try again.", comment: "")
        }
    }
}

struct GHSError: Identifiable {
    let id = UUID()
    let error: GitHubSearchError
}
