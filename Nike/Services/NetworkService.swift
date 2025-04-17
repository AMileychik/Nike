//
//  TopPicksLoader.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/3/24.
//

import Foundation

enum NetworkError: Error {
    case statusCode
    case decodingError(Error)
}

protocol NetworkServiceProtocol {
    func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, Error>) -> ())
    func loadShopData(completion: @escaping (Result<ShopSectionsResponse, Error>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    //MARK: - HomeSectionsResponse
    func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, Error>) -> ()) {
        guard let url = URL(string: "http://localhost:3001/home") else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.statusCode))
            }
            
            guard let data else { return }
            
            do {
                let decodedData = try self.decoder.decode(HomeSectionsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }.resume()
    }
    
    //MARK: - ShopSectionsResponse
    func loadShopData(completion: @escaping (Result<ShopSectionsResponse, any Error>) -> ()) {
        guard let url = URL(string: "http://localhost:3001/shop") else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.statusCode))
            }
            
            guard let data else { return }
            
            do {
                let decodedData = try self.decoder.decode(ShopSectionsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }.resume()
    }
}



