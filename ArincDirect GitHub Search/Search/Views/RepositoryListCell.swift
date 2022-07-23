//
//  RepositoryListCell.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/21/22.
//

import SwiftUI

struct RepositoryListCell: View {
    let unavailableDataString = NSLocalizedString("RepositoryListCell.unavailableDataString", bundle: .main, value: "Data unavailable", comment: "")
    let starCountString = NSLocalizedString("RepositoryListCell.starCountString", bundle: .main, value: "%@ stars", comment: "")
    let repository: RepositoryDescription
    
    init(repository: RepositoryDescription) {
        self.repository = repository
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(repository.name ?? unavailableDataString)
                .font(.headline)
                .padding(.bottom, 8)
            Text(repository.description ?? unavailableDataString)
                .font(.subheadline)
                .padding(.bottom, 8)
            HStack(alignment: .top, spacing: 0) {
                Text(String(format: starCountString, repository.stargazers_count?.formatDecimal() ?? 0))
                    .font(.footnote)
                Spacer()
                Text(repository.language ?? unavailableDataString)
                    .font(.footnote)
            }
        }
        .listRowBackground(Color.ghBackground)
        .listRowSeparatorTint(Color.ghGrayAccent)
        .foregroundColor(.ghGrayAccent)
        .padding(.vertical, 12)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct RepositoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListCell(repository: RepositoryDescription())
    }
}
