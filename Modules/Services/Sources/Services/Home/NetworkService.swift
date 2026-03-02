//
//  File.swift
//  
//
//  Created by Александр Милейчик on 6/23/25.
//

import Foundation
import AppDomain
import AppInterface
import Combine

// MARK: - NetworkError
public enum NetworkError: Error {
    case statusCode
    case decodingError(Error)
}

public protocol NetworkServiceProtocol {
    func loadHomeData() async throws -> HomeSectionsResponse
    func loadShopData() async throws -> ShopSectionsResponse
}

public final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func loadHomeData() async throws -> HomeSectionsResponse {
        guard let url = URL(string: "http://localhost:3001/home") else {
            throw NetworkError.statusCode
        }
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.statusCode
        }
        
        do {
            let decoded = try decoder.decode(HomeSectionsResponse.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    public func loadShopData() async throws -> ShopSectionsResponse {
        guard let url = URL(string: "http://localhost:3001/shop") else {
            throw NetworkError.statusCode
        }
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.statusCode
        }
        
        do {
            let decoded = try decoder.decode(ShopSectionsResponse.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}





//public enum NetworkError: Error {
//    case statusCode
//    case decodingError(Error)
//}
//
//public final class NetworkService: NetworkServiceProtocol {
//    
////    private let session: URLSession
////    private let decoder: JSONDecoder
////    
////    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
////        self.session = session
////        self.decoder = decoder
////    }
//    
//    private let session = URLSession.shared
//    private let decoder = JSONDecoder()
//    
//    public init() {}
//    
//    // MARK: - HomeSectionsResponse
//    public func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, Error>) -> ()) {
//        guard let url = URL(string: "http://localhost:3001/home") else { return }
//        let request = URLRequest(url: url)
//        
//        session.dataTask(with: request) { data, response, error in
//            if error != nil {
//                completion(.failure(NetworkError.statusCode))
//            }
//            
//            guard let data else { return }
//            
//            do {
//                let decodedData = try self.decoder.decode(HomeSectionsResponse.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(decodedData))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(NetworkError.decodingError(error)))
//                }
//            }
//        }.resume()
//    }
//    
//    // MARK: - ShopSectionsResponse
//    public func loadShopData(completion: @escaping (Result<ShopSectionsResponse, Error>) -> ()) {
//        guard let url = URL(string: "http://localhost:3001/shop") else { return }
//        let request = URLRequest(url: url)
//        
//        session.dataTask(with: request) { data, response, error in
//            if error != nil {
//                completion(.failure(NetworkError.statusCode))
//            }
//            
//            guard let data else { return }
//            
//            do {
//                let decodedData = try self.decoder.decode(ShopSectionsResponse.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(decodedData))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(NetworkError.decodingError(error)))
//                }
//            }
//        }.resume()
//    }
//}









//import Foundation
//import AppDomain
//import AppInterface
//
//public enum NetworkError: Error {
//    case invalidURL
//    case noData
//    case statusCode
//    case decoding(Error)
//}
//
//public final class NetworkService: NetworkServiceProtocol {
//
//    private let session: URLSession()
//    private let decoder: JSONDecoder()
//
////    public init(
////        session: URLSession = .shared,
////        decoder: JSONDecoder = JSONDecoder()
////    ) {
////        self.session = session
////        self.decoder = decoder
////    }
//    
//    public init() {}
//
//    // MARK: - Generic Request Loader
//    private func load<T: Decodable>(
//        _ type: T.Type,
//        from urlString: String,
//        completion: @escaping (Result<T, Error>) -> Void
//    ) {
//        guard let url = URL(string: urlString) else {
//            return completion(.failure(NetworkError.invalidURL))
//        }
//
//        let request = URLRequest(url: url)
//
//        session.dataTask(with: request) { [weak self] data, response, error in
//            guard let self else { return }
//
//            if error != nil {
//                return completion(.failure(NetworkError.statusCode))
//            }
//
//            guard let data else {
//                return completion(.failure(NetworkError.noData))
//            }
//
//            do {
//                let decoded = try self.decoder.decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(decoded))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(NetworkError.decoding(error)))
//                }
//            }
//
//        }.resume()
//    }
//
//    // MARK: - Home
//    public func loadHomeData(
//        completion: @escaping (Result<HomeSectionsResponse, Error>) -> ()
//    ) {
//        load(HomeSectionsResponse.self, from: "http://localhost:3001/home", completion: completion)
//    }
//
//    // MARK: - Shop
//    public func loadShopData(
//        completion: @escaping (Result<ShopSectionsResponse, Error>) -> ()
//    ) {
//        load(ShopSectionsResponse.self, from: "http://localhost:3001/shop", completion: completion)
//    }
//}
