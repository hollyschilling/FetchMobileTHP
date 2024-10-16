//
//  UrlSessionLoader.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation

struct UrlSessionLoader: UrlLoader {

    enum Errors {
        struct NoResponse: Error {
            var data: Data?
        }
        
        struct NoData: Error {
            var response: HTTPURLResponse
        }
        
        struct UnexpectedStatusCode: Error {
            var statusCode: Int
            var response: HTTPURLResponse
            var data: Data?
        }
    }
    
    let session: URLSession
    let defaultTimeout: TimeInterval
    let defaultCachePolicy: URLRequest.CachePolicy
    
    init(session: URLSession = .shared, defaultCachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, defaultTimeout: TimeInterval = 5) {
        self.session = session
        self.defaultCachePolicy = defaultCachePolicy
        self.defaultTimeout = defaultTimeout
    }
    
    func fetchAsync(url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            fetch(url: url) { result in
                continuation.resume(with: result)
            }
        }
    }

    func fetchAsync(request: URLRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            fetch(request: request) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    func fetch(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(
            url: url,
            cachePolicy: defaultCachePolicy,
            timeoutInterval: defaultTimeout)
        fetch(request: request, completionHandler: completionHandler)
    }
    
    func fetch(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error {
                completionHandler(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(Errors.NoResponse(data: data)))
                return
            }
            guard response.statusCode == 200 else {
                completionHandler(.failure(Errors.UnexpectedStatusCode(statusCode: response.statusCode, response: response, data: data)))
                return
            }
            guard let data else {
                completionHandler(.failure(Errors.NoData(response: response)))
                return
            }
            completionHandler(.success(data))
        }
        task.resume()
    }
}
