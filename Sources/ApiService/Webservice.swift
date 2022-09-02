//
//  SimpleNetworking.swift
//
//  Created by Mohammad Azam on 10/1/21.
//

import Foundation

// MARK: - Network Error
public enum NetworkError: Error {
    case badRequest
    case decodingError
}

// MARK: - Web Service
public class Webservice {
    
    public init() { }
    
    // MARK: - RESTful GET Method
    public func fetch<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void)  {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.decodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
        }.resume()
    }
}
