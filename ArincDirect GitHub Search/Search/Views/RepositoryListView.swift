//
//  RepositoryListView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/21/22.
//

import SwiftUI
import CoreData

struct RepositoryListView: View {
    @Environment(\.managedObjectContext) var context
    
    let repositories: [RepositoryDescription]
    let bookmarkText = NSLocalizedString("RepositoryListView.bookmark", bundle: .main, value: "Bookmark", comment: "")
    
    init(repositories: [RepositoryDescription]? = []) {
        self.repositories = repositories ?? []
    }
    
    var body: some View {
        List(repositories, id: \.self) { repository in
            RepositoryListCell(repository: repository)
                .swipeActions {
                    Button(bookmarkText) {
                        bookmarkRepo(repository: repository)
                    }
                    .tint(.blue)
                }
        }
        .background(Color.ghBackground)
        .listStyle(.plain)
    }
    
    func bookmarkRepo(repository: RepositoryDescription) {
        let repo = Bookmark(context: context)
        repo.id = UUID()
        repo.name = repository.name
        repo.desc = repository.description
        repo.language = repository.language
        repo.stars = repository.stargazers_count ?? 0
        try? context.save()
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(repositories: [])
    }
}
