//
//  SearchView.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var appModel: AppViewModel
    var animation: Namespace.ID
    
    @StateObject private var viewModel = SearchViewModel(
        searchProductUseCase: SearchProductUseCase(
            searchProductsRepository: SarchProductsRepository(
                SearchProductsRemoteDataSource: SearchProductsRemoteDataSource(networker: Networker())
            )
        )
    )
    @State private var selectedViewMode: ViewMode = .list
    
    var body: some View {
        
        HeaderSearchView(delegate: self)
        
        Picker("Select View", selection: $selectedViewMode) {
            ForEach(ViewMode.allCases, id: \.self) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        
        if selectedViewMode == .grid {
            NavigationStack {
                GridView(delegate: self) {
                    ForEach(viewModel.allProducts, id: \.id) { product in
                        SearchProductGridCell(animation: animation, item: product)
                            .foregroundColor(.white)
                            .onAppear {
                                tryToLoadMoreProducts(for: product)
                            }
                    }
                }
            }
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.allProducts, id: \.self) { product in
                        SearchProductListCell(animation: animation, item: product)
                            .onAppear {
                                tryToLoadMoreProducts(for: product)
                            }
                    }
                }
            }
        }
    }
        
    
    func tryToLoadMoreProducts(for product: ResultItem) {
        if product == viewModel.lastProduct(),
           viewModel.hasNextPage() ?? false,
           !viewModel.isLoading {
            viewModel.loadMoreProducts()
        }
    }
}

// MARK: - SearchDelegate

extension SearchView: SearchDelegate {
    
    var placeHolder: String { return "Buscar en todo Mercado libre" }
    
    func search(query: String) {
        if query.isEmpty {
            viewModel.clearSearch()
        }
        guard query.count > 3 else { return }
        viewModel.fetchProductSerach(query: query)
    }
}

// MARK: - GridViewDelegate -

extension SearchView: GridViewDelegate {
    
    var isSearching: Bool {
        viewModel.isLoading
    }
    
    func hasNext() -> Bool {
        viewModel.hasNextPage() ?? false
    }
}
