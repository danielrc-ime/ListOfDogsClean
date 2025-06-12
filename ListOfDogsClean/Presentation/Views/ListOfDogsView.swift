//
//  ListOfDogsView.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 11/06/25.
//

import SwiftUI
import SwiftData

struct ListOfDogsView: View {
    @StateObject var viewModel: ListOfDogsViewModel
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.dogs) { dog in
                    DogRowView(dog: dog)
                        .listRowBackground(Color(.colorBackground))
                        .listRowSeparator(Visibility.hidden)
                }
            }
            .listStyle(.plain)
            .background(Color(.colorBackground))
            .navigationTitle("Dogs We Love")
            .task {
                await viewModel.loadDogs()
            }
        }
    }
}


#Preview {
    let networkService = URLSessionNetworkService()
    let apiSource = APISource(networkService: networkService)
    let container = try! ModelContainer(for: DogEntity.self)
    let context = container.mainContext
    let repository = DogRepositoryImpl(apiSource: apiSource, context: context)
    let getDogsUsecase = GetDogsUseCaseImpl(repository: repository)
    let getDogImageUseCase = GetDogImageUseCaseImpl(repository: repository)
    let viewModel = ListOfDogsViewModel(getDogsUseCase: getDogsUsecase, getDogImageUseCase: getDogImageUseCase)
    ListOfDogsView(viewModel: viewModel)
}
