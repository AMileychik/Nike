//
//  File.swift
//  
//
//  Created by Александр Милейчик on 1/4/26.
//

import Foundation
import AppInterface

public protocol RequestBuilding {
    func makeRequest(for endpoint: Endpoint) throws -> URLRequest
}

public final class RequestBuilder: RequestBuilding {
    
    private let baseURL: URL
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public func makeRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 30
        return request
    }
}
