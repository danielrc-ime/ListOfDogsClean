//
//  DogListViewModelTests.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 12/06/25.
//


import XCTest
@testable import ListOfDogsClean

final class DogListViewModelTests: XCTestCase {
    
    let networkService = MockService()

    func testLoadDogsSuccessfully() async throws {
        let apiSource = APISource(networkService: networkService)
        let repository = DogRepositoryImpl(apiSource: apiSource, context: nil)
        let getDogsUsecase = GetDogsUseCaseImpl(repository: repository)
        let getDogImageUseCase = GetDogImageUseCaseImpl(repository: repository)
        
        let viewModel = await ListOfDogsViewModel(getDogsUseCase: getDogsUsecase, getDogImageUseCase: getDogImageUseCase)

        let expectedDogs: [Dog] = try await repository.fetchDogs()
        // Act
        await viewModel.loadDogs()

        // Assert
        await MainActor.run {
            XCTAssertEqual(viewModel.dogs.count, expectedDogs.count)
            XCTAssertNil(viewModel.errorMessage)
        }
    }

}
