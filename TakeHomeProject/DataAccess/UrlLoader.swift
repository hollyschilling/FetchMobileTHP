//
//  UrlLoader.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation

protocol UrlLoader {
    
    func fetchAsync(url: URL) async throws -> Data
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

extension UrlLoader {
    func fetchJsonAsync<ResultType>(url: URL, decoder: JSONDecoder = JSONDecoder()) async throws -> ResultType where ResultType: Decodable {
        let data = try await fetchAsync(url: url)
        let parsed = try decoder.decode(ResultType.self, from: data)
        return parsed        
    }
}
