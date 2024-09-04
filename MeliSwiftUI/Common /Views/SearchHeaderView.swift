//
//  SearchHeaderView.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import SwiftUI

protocol SearchDelegate {
    var placeHolder: String { get }
    func search(query: String)
}

struct HeaderSearchView: View {
    
    // MARK: - Private properties -
    
    @State private var fieldTextSearch: String = .empty
    @State private var isEditing: Bool = false
    @State private var isFocus: Bool = false
    
    // MARK: - Public properties -
    
    let delegate: SearchDelegate
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 16)
                    .opacity(0.5)
                
                TextField(delegate.placeHolder, text: $fieldTextSearch)
                    .padding(8)
                    .font(.callout)
                    .foregroundColor(Color.gray)
                    .accentColor(Color.red)
                    .onTapGesture {
                        isFocus = true
                        isEditing = true
                    }
                    .onChange(of: fieldTextSearch) { _, _ in
                        delegate.search(query: fieldTextSearch)
                    }
                    .showClearButton($fieldTextSearch)
                
            }
            .background(Color.white)
            .clipShape(Capsule())
            .padding(16)
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    isFocus = false
                    fieldTextSearch = .empty
                    hideKeyboard()
                    delegate.search(query: fieldTextSearch)
                }, label: {
                    Text("Cancel")
                })
                .frame(height: 21)
                .padding(.trailing, 15)
                .foregroundColor(.white)
            }
        }
        .background(.yellow)
        .onChange(of: fieldTextSearch) { _, _ in
            isEditing = !fieldTextSearch.isEmpty || isFocus
        }
    }
}

// MARK: - SearchDelegate -

extension HeaderSearchView: SearchDelegate {
    
    var placeHolder: String {
        self.delegate.placeHolder
    }
    
    func search(query: String) {
        self.delegate.search(query: query)
    }
}
