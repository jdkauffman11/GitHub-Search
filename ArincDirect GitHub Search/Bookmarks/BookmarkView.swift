//
//  BookmarkView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))]) var bookmarks: FetchedResults<Bookmark>
    
    let bookmarksTitle = NSLocalizedString("BookmarkView.bookmark", bundle: .main, value: "Bookmarks", comment: "")
    let removeText = NSLocalizedString("RepositoryListView.removeText", bundle: .main, value: "Remove", comment: "")
    
    var body: some View {
        NavigationView {
            List(bookmarks, id: \.self) { bookmarkedRepo in
                RepositoryListCell(repository: RepositoryDescription(name: bookmarkedRepo.name,
                                                                     description: bookmarkedRepo.desc,
                                                                     language: bookmarkedRepo.language,
                                                                     stargazers_count: bookmarkedRepo.stars))
                .swipeActions {
                    Button(removeText) {
                        delete(bookmark: bookmarkedRepo)
                    }
                    .tint(.red)
                }
            }
            .navigationTitle(bookmarksTitle)
            .background(Color.ghBackground)
            .listStyle(.plain)
        }
    }
    
    func delete(bookmark: Bookmark) {
        do {
            context.delete(bookmark)
            try context.save()
        } catch {
            print("Unable to delete item")
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
