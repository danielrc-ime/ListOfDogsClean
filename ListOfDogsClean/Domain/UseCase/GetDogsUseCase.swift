//
//  DogUseCase.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 10/06/25.
//
import Foundation

protocol GetDogsRepositoryProtocol {
    func fetchDogs() async throws -> [Dog]
    func fetchDogImage(endpoint: String) async throws -> Data
}

struct GetDogsUseCaseImpl {
    
    private let repository: GetDogsRepositoryProtocol
    
    init(repository: GetDogsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Dog] {
        try await repository.fetchDogs()
    }
    
}
