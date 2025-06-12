//
//  GetDogsUseCaseTests.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 12/06/25.
//


import XCTest
import SwiftData
@testable import ListOfDogsClean

final class GetDogsUseCaseTests: XCTestCase {
    
    let networkService = MockService()

    func testExecuteReturnsDogs() async throws {
        let apiSource = APISource(networkService: networkService)
        let repository = DogRepositoryImpl(apiSource: apiSource, context: nil)
        
        let expectedDogs: [Dog] = try await repository.fetchDogs()

        let useCase = GetDogsUseCaseImpl(repository: repository)

        // Act
        let dogs = try await useCase.execute()

        // Assert
        XCTAssertEqual(dogs.count, expectedDogs.count)
        XCTAssertEqual(dogs.first?.dogName, "Rex")
    }
}
