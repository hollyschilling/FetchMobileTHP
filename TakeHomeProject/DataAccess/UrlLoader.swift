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
