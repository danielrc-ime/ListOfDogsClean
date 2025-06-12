//
//  Dog.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 10/06/25.
//
import Foundation

struct Dog: Identifiable, Codable {
    var id: UUID
    let dogName: String
    let description: String
    let age: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case dogName
        case description
        case age
        case image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dogName = try container.decode(String.self, forKey: .dogName)
        description = try container.decode(String.self, forKey: .description)
        age = try container.decode(Int.self, forKey: .age)
        image = try container.decode(String.self, forKey: .image)
        id = UUID()
    }
    
    init(id: UUID = UUID(), dogName: String, description: String, age: Int, image: String) {
        self.id = id
        self.dogName = dogName
        self.description = description
        self.age = age
        self.image = image
    }
}
