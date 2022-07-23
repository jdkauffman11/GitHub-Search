//
//  View+Extensions.swift
//  ArincDirect GitHub Search
//
//  Created by Jordan Kauffman on 7/21/22.
//

import Foundation
import SwiftUI

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
