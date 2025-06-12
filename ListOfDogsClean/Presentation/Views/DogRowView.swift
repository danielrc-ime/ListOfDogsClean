//
//  DogRowView.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 11/06/25.
//

import SwiftUI
import SwiftData

struct DogRowView: View {
    
    @StateObject var dog: DogViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(height: 200)
                .foregroundStyle(Color.clear)
            HStack {
                Spacer(minLength: 160)
                VStack(alignment: .leading, spacing: 12) {
                    Text(dog.dogName).font(.title)
                        .foregroundStyle(.fontColorTitle)
                    Text(dog.description).font(.subheadline)
                        .foregroundStyle(.fontColorDescription)
                        
                    Text("Almost: \(dog.age) years").font(.subheadline)
                        .foregroundStyle(.fontColorTitle)
                        .bold()
                }
                .frame(height: 140)
                Spacer()
            }
            .padding([.top, .bottom, .trailing])
            .background(Color.white)
            .cornerRadius(20)
            .overlay(alignment: .bottom, content: {
                HStack {
                    if let image = dog.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 200)
                            .cornerRadius(20)
                    } else {
                        ProgressView()
                    }
                    Spacer()
                }
            })
        }
        .task {
            await dog.loadDogImage()
        }
    }
}

#Preview {
    let dog = ModelData().dogs
    let networkService = URLSessionNetworkService()
    let apiSource = APISource(networkService: networkService)
    let container = try! ModelContainer(for: DogEntity.self)
    let context = container.mainContext
    let repository = DogRepositoryImpl(apiSource: apiSource, context: context)
    let getDogImageUseCase = GetDogImageUseCaseImpl(repository: repository)
    let dogViewModel = DogViewModel(dog: dog[0], getDogImageUseCase: getDogImageUseCase)
    Group {
        DogRowView(dog: dogViewModel)
    }
    
}
