//
//  GetDogImageUseCase.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 11/06/25.
//
import Foundation

struct GetDogImageUseCaseImpl {
    
    private let repository: GetDogsRepositoryProtocol
    
    init(repository: GetDogsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(endpoint: String) async throws -> Data {
        try await repository.fetchDogImage(endpoint: endpoint)
    }
    
}
