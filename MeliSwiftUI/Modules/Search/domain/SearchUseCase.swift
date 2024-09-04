//
//  SearchUseCase.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import Foundation
import Combine

protocol SearchProductUseCaseProtocol {
    func searchProduct(query: String, offset: String) -> AnyPublisher<SearchResponse, CustomError>
}

class SearchProductUseCase {

    // MARK: - Private properties -
    private let searchProductsRepository: SearchProductsRepositoryProtocol
    
    // MARK: - Lifecycle -
    init(searchProductsRepository: SearchProductsRepositoryProtocol) {
        self.searchProductsRepository = searchProductsRepository
    }
}

// MARK: - SearchProductsRepositoryProtocol -
extension SearchProductUseCase: SearchProductsRepositoryProtocol {

    func getSearchList(query: String, offset: String) -> AnyPublisher<SearchResponse, CustomError> {
        searchProductsRepository.getSearchList(query: query, offset: offset)
    }
}
