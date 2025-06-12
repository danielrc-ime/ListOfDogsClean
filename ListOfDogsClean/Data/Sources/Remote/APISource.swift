//
//  DataFetcher.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 11/06/25.
//

import Foundation

class APISource {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        return try await networkService.request(endpoint)
    }
    
    func fetchRawData(endpoint: String) async throws -> Data {
        return try await networkService.requestData(endpoint)
    }
}
