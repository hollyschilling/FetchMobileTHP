//
//  UrlLoader.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation

protocol UrlLoader {
    
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

extension UrlLoader {
    
    func fetchAsync(url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            fetch(url: url) { result in
                continuation.resume(with: result)
            }
        }
    }
}
