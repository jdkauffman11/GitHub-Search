//
//  SearchTextField.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/21/22.
//

import SwiftUI

struct SearchTextField: View {
    
    private let searchPlaceholder = NSLocalizedString("SearchView.searchPlaceholder", bundle: .main, value: "Type a repository name, description or 'README'", comment: "search field placeholder notifying user of searchable content")
    
    @State private var searchContents = ""
    
    var body: some View {
        TextField(searchPlaceholder, text: $searchContents)
            .padding(.all, 16)
            .font(Font.system(size: 13))
            .textFieldStyle(.roundedBorder)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField()
    }
}
