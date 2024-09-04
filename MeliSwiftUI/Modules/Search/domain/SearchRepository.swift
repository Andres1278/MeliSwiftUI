//
//  SearchRepository.swift
//  MeliSwiftUI
//
//  Created by Pedro Andres Villamil on 31/08/24.
//

import Foundation
import Combine

protocol SearchProductsRepositoryProtocol {
    func getSearchList(query: String, offset: String) -> AnyPublisher<SearchResponse, CustomError>
}

class SarchProductsRepository {
    
    // MARK: - Private properties -
    private let searchProductsRemoteDataSource: SearchProductsRemoteDataSource
    
    // MARK: - Lifecycle -
    init(SearchProductsRemoteDataSource: SearchProductsRemoteDataSource) {
        self.searchProductsRemoteDataSource = SearchProductsRemoteDataSource
    }
}

extension SarchProductsRepository: SearchProductsRepositoryProtocol {
    
    func getSearchList(query: String, offset: String) -> AnyPublisher<SearchResponse, CustomError> {
        searchProductsRemoteDataSource.getSearchList(query: query, offset: offset)
    }
}
