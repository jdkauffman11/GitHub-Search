//
//  ResultCountView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/21/22.
//

import SwiftUI

struct ResultCountView: View {
    
    private let resultsCount = NSLocalizedString("SearchView.searchResultCount", bundle: .main, value: "Showing %d of %@ results", comment: "search result count")
    private let showingResultCount: Int
    private let totalResultCount: Float
    init(showingResultCount: Int? = 0, totalResultCount: Float? = 0) {
        self.showingResultCount = showingResultCount ?? 0
        self.totalResultCount = totalResultCount ?? 0
    }
    
    var body: some View {
        Text(String(format: resultsCount, showingResultCount, totalResultCount.formatDecimal()))
            .font(Font.system(size: 14))
            .padding(.horizontal, 16)
            .foregroundColor(.ghGrayAccent)
            .background(Color.ghBackground)
    }
}

struct ResultCountView_Previews: PreviewProvider {
    static var previews: some View {
        ResultCountView()
    }
}

