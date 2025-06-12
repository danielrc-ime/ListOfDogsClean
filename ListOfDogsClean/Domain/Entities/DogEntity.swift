//
//  DogEntity.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 12/06/25.
//

import Foundation
import SwiftData

@Model
class DogEntity {
    var id: UUID
    var dogName: String
    var dogDescription: String
    var age: Int
    var image: String

    init(dog: Dog) {
        self.id = dog.id
        self.dogName = dog.dogName
        self.dogDescription = dog.description
        self.age = dog.age
        self.image = dog.image
    }

    func toDomain() -> Dog {
        return Dog(dogName: dogName, description: dogDescription, age: age, image: image)
    }
}
