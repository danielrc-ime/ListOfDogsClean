//
//  ViewModel.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 11/06/25.
//

import SwiftUI

@MainActor
final class ListOfDogsViewModel: ObservableObject {
    @Published var dogs: [DogViewModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getDogsUseCase: GetDogsUseCaseImpl
    private let getDogImageUseCase: GetDogImageUseCaseImpl
    
    init(getDogsUseCase: GetDogsUseCaseImpl, getDogImageUseCase: GetDogImageUseCaseImpl) {
        self.getDogsUseCase = getDogsUseCase
        self.getDogImageUseCase = getDogImageUseCase
    }
    
    func loadDogs() async {
        isLoading = true
        do {
            let model = try await getDogsUseCase.execute()
            dogs = model.map({ dog in
                return DogViewModel(dog: dog, getDogImageUseCase: getDogImageUseCase)
            })
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

@MainActor
final class DogViewModel: @preconcurrency Identifiable, ObservableObject {
    @Published var image: UIImage?
    
    private let dog: Dog
    private let getDogImageUseCase: GetDogImageUseCaseImpl
    
    init(dog: Dog, getDogImageUseCase : GetDogImageUseCaseImpl) {
        self.dog = dog
        self.getDogImageUseCase = getDogImageUseCase
    }
    
    var id: UUID {
        return dog.id
    }
    var dogName: String {
        return dog.dogName
    }
    var description: String {
        return dog.description
    }
    var age: Int {
        return dog.age
    }
    
    func loadDogImage() async {
        do {
            let data = try await getDogImageUseCase.execute(endpoint: dog.image)
            image = UIImage(data: data)
        } catch {
            debugPrint(error.localizedDescription)
            image = nil
        }
    }
}
