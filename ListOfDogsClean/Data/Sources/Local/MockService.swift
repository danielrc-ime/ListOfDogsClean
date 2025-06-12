//
//  MockService.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 12/06/25.
//

import Foundation
import UIKit

struct MockService: NetworkService {
    func request<T>(_ endpoint: String) async throws -> T where T : Decodable {
        let filename: String = "dogsData.json"
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }


        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }


        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func requestData(_ endpoint: String) async throws -> Data {
        
        if let image = UIImage(named: "coraje") {
            // Convierte la imagen a datos usando JPEG o PNG
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                return imageData
            } else if let imageData = image.pngData() {
                // Aquí tienes los datos de la imagen en formato PNG
                return imageData
            } else {
                fatalError("Error al convertir la imagen a datos")
            }
        } else {
            fatalError("No se pudo cargar la imagen")
        }
        fatalError("Uknown error")
    }
    
    
}
