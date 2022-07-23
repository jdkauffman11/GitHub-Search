//
//  SearchFilterView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import SwiftUI

struct SearchFilterView: View {
    
    let applyText = NSLocalizedString("SearchFilterView.applyText", bundle: .main, value: "Apply", comment: "")
    let searchByLanguage = NSLocalizedString("SearchFilterView.searchByLanguage", bundle: .main, value: "Search by language", comment: "")
    let programmingLanguage = NSLocalizedString("SearchFilterView.programmingLanguage", bundle: .main, value: "Programming language", comment: "")
    let sortAscendingString = NSLocalizedString("SearchFilterView.sortAscending", bundle: .main, value: "Sort ascending", comment: "")
    let resultsPerPageString = NSLocalizedString("SearchFilterView.resultsPerPageString", bundle: .main, value: "Results per page:", comment: "")
    
    private var filterModel: RepositorySearchFilter
    private var dismissView: () -> Void
    @State private var languageString = ""
    @State private var resultsPerPage = 25.0
    @State private var sortAscending = false
    
    init(filterModel: RepositorySearchFilter, dismissView: @escaping () -> Void) {
        self.filterModel = filterModel
        self.dismissView = dismissView
        _languageString = State(initialValue: filterModel.language ?? "")
        _resultsPerPage = State(initialValue: Double(filterModel.resultsPerPage ?? 25))
        _sortAscending = State(initialValue: filterModel.orderAscending ?? false)
    }
    
    var body: some View {
        VStack {
            // Search by programming language field
            HStack {
                Text(searchByLanguage)
                Spacer()
                TextField(programmingLanguage, text: $languageString)
                    .foregroundColor(.ghBackground)
                    .textFieldStyle(.roundedBorder)
                
            }.padding()
            // # of results to return per page
            HStack {
                VStack {
                    Slider(value: $resultsPerPage, in: 0...100, step: 1) {
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("100")
                    } onEditingChanged: { _ in }
                    Text("\(resultsPerPageString) \(Float(self.resultsPerPage).formatDecimal())")
                        .foregroundColor(Color.ghGrayAccent)
                }
            }
            .padding()
            // Sort ascenidning if true, descending if false
            Toggle(sortAscendingString, isOn: $sortAscending)
                .toggleStyle(SwitchToggleStyle(tint: Color.ghBackground))
                .padding()
            
            Button(applyText) {
                filterModel.language = languageString
                filterModel.resultsPerPage = Int(resultsPerPage)
                filterModel.orderAscending = sortAscending
                dismissView()
            }
            .tint(.ghGrayAccent)
            .padding(.vertical)
            .font(.system(size: 17, weight: .bold, design: .default))
        }
        .background(Color(red: 82/255, green: 88/255, blue: 96/255)) // another color from the github color palette
        .cornerRadius(40)
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView(filterModel: RepositorySearchFilter(), dismissView: {})
    }
}
