//
//  SearchFilterView.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/22/22.
//

import SwiftUI

struct SearchFilterView: View {
    
    let searchByLanguage = NSLocalizedString("SearchFilterView.searchByLanguage", bundle: .main, value: "Search by language", comment: "")
    let programmingLanguage = NSLocalizedString("SearchFilterView.programmingLanguage", bundle: .main, value: "Programming language", comment: "")
    let sortAscendingString = NSLocalizedString("SearchFilterView.sortAscending", bundle: .main, value: "Sort ascending", comment: "")
    let resultsPerPageString = NSLocalizedString("SearchFilterView.resultsPerPageString", bundle: .main, value: "Results per page:", comment: "")
    
    private var filterModel: RepositorySearchFilter
    @State private var languageString = ""
    @State private var resultsPerPage = 25.0
    @State private var sortAscending = false
    
    init(filterModel: RepositorySearchFilter) {
        self.filterModel = filterModel
    }
    
    var body: some View {
        VStack {
            // Search by programming language field
            HStack {
                // create bindings to capture change of values
                let languageBinding = getLanguageBinding()
                Text(searchByLanguage)
                Spacer()
                TextField(programmingLanguage, text: languageBinding)
                    .foregroundColor(.ghBackground)
                    .textFieldStyle(.roundedBorder)
                
            }.padding()
            // # of results to return per page
            HStack {
                VStack {
                    let resultCountBinding = getResultsBinding()
                    Slider(value: resultCountBinding, in: 0...100, step: 1) {
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
            let sortBinding = getSortBinding()
            Toggle(sortAscendingString, isOn: sortBinding)
                .toggleStyle(SwitchToggleStyle(tint: Color.ghBackground))
                .padding()
        }
        .background(Color(red: 82/255, green: 88/255, blue: 96/255)) // another color from the github color palette
        .cornerRadius(40)
    }
    
    // added getter functions for the binding creation to keep true view code cleaner
    private func getLanguageBinding() -> Binding<String> {
        return Binding<String>(get: {
            filterModel.language ?? languageString
        }, set: {
            languageString = $0
            filterModel.language = languageString
        })
    }
    
    private func getResultsBinding() -> Binding<Double> {
        return Binding<Double>(get: {
            guard let results = filterModel.resultsPerPage else { return resultsPerPage }
            return Double(results)
        }, set: {
            resultsPerPage = $0
            filterModel.resultsPerPage = Int(resultsPerPage) // will never be more than 100
        })
    }
    
    private func getSortBinding() -> Binding<Bool> {
        return Binding<Bool>(get: {
            filterModel.orderAscending ?? sortAscending
        }, set: {
            sortAscending = $0
            filterModel.orderAscending = sortAscending
        })
    }
    
    private func getResultsPerPage() -> String {
        guard let resultsPerPage = filterModel.resultsPerPage else { return Float(self.resultsPerPage).formatDecimal() }
        return Float(resultsPerPage).formatDecimal()
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView(filterModel: RepositorySearchFilter())
    }
}
