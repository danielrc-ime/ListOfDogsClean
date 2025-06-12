//
//  NetworkService.swift
//  ListOfDogsClean
//
//  Created by Daniel Alberto Rodriguez Cielo on 10/06/25.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: String) async throws -> T
    func requestData(_ endpoint: String) async throws -> Data
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case requestFailed(Error)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct URLSessionNetworkService: NetworkService {
    func request<T: Decodable>(_ endpoint: String) async throws -> T {
        
        guard let url = URL(string: endpoint) else {
            debugPrint(NetworkError.invalidURL)
            throw NetworkError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                debugPrint(NetworkError.invalidResponse)
                throw NetworkError.invalidResponse
            }
        } catch {
            debugPrint(NetworkError.requestFailed(error))
            throw NetworkError.requestFailed(error)
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint(NetworkError.decodingError(error))
            throw NetworkError.decodingError(error)
        }
    }
    
    //Request for Raw Data
    func requestData(_ endpoint: String) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            debugPrint(NetworkError.invalidURL)
            throw NetworkError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                debugPrint(NetworkError.invalidResponse)
                throw NetworkError.invalidResponse
            }
            return data
        } catch {
            debugPrint(NetworkError.requestFailed(error))
            throw NetworkError.requestFailed(error)
        }
    }
}

