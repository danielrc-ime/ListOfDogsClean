//
//  ListOfDogsCleanApp.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 10/06/25.
//

import SwiftUI
import SwiftData

@main
struct ListOfDogsCleanApp: App {
    var body: some Scene {
        WindowGroup {
            // dependency injection, can select another Service like Alamofire or Mock
            let networkService = URLSessionNetworkService()
            let apiSource = APISource(networkService: networkService)
            // Needed for SwiftData
            let container = try! ModelContainer(for: DogEntity.self)
            let context = container.mainContext
            // Repository that comunicates with services
            let repository = DogRepositoryImpl(apiSource: apiSource, context: context)
            // Declare Use Cases for the View
            let getDogsUsecase = GetDogsUseCaseImpl(repository: repository)
            let getDogImageUseCase = GetDogImageUseCaseImpl(repository: repository)
            // Using View Model to prepare data for View
            let viewModel = ListOfDogsViewModel(getDogsUseCase: getDogsUsecase, getDogImageUseCase: getDogImageUseCase)
            ListOfDogsView(viewModel: viewModel)
                .modelContainer(container)
        }
    }
}
