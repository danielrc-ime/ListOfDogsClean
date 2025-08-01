//
//  DogRepository.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 10/06/25.
//

import Foundation
import SwiftData

class DogRepositoryImpl: GetDogsRepositoryProtocol {
    
    private let apiSource: APISource
    private let context: ModelContext?
    
    init(apiSource: APISource, context: ModelContext?) {
        self.apiSource = apiSource
        self.context = context
    }
    
    private func fetchWithRemote() async throws -> [Dog] {
        let endpoint = "https://jsonblob.com/api/1151549092634943488"
        let dogs: [Dog] = try await apiSource.fetchData(endpoint: endpoint)
        return dogs
    }
    
    func fetchDogs() async throws -> [Dog] {
        // Prepare for SwiftData
        let descriptor = FetchDescriptor<DogEntity>()
        // Check if context is available
        guard let context = context else {
            return try await fetchWithRemote()
        }
        // Check if user has saved Data
        let localDogs = try context.fetch(descriptor)
        
        if localDogs.isEmpty {
            let dogs: [Dog] = try await fetchWithRemote()
            // Save in SwiftData
            for dog in dogs {
                context.insert(DogEntity(dog: dog))
            }
            try context.save()
            return dogs
        } else {
            // User has saved Data
            return localDogs.map { $0.toDomain()}
        }
        
    }
    
    func fetchDogImage(endpoint: String) async throws -> Data {
        return try await apiSource.fetchRawData(endpoint: endpoint)
    }
    
}
