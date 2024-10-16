//
//  UrlSessionLoaderTests.swift
//  TakeHomeProjectTests
//
//  Created by Holly on 10/16/24.
//

import Testing
import Foundation

@testable
import TakeHomeProject

struct UrlSessionLoaderTests {

    @Test
    func fetchValidUrlAsync() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        
        let loader = UrlSessionLoader(session: .shared, defaultCachePolicy: .reloadIgnoringLocalAndRemoteCacheData, defaultTimeout: 2)
        
        _ = try await loader.fetchAsync(url: url)
    }

    @Test
    func fetchInvalidUrlAsync() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/xxxxxxx.json")!
        
        let loader = UrlSessionLoader(session: .shared, defaultCachePolicy: .reloadIgnoringLocalAndRemoteCacheData, defaultTimeout: 2)
        
        await #expect(throws: (any Error).self){
            _ = try await loader.fetchAsync(url: url)
        }
    }

}
