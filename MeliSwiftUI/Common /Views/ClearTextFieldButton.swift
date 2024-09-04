//
//  ClearTextFieldButton.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    
    // MARK: - Public properties -
    @Binding var fieldText: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = .empty
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.secondary)
                        .padding(.trailing, 5)
                    }
                }
            }
    }
}
