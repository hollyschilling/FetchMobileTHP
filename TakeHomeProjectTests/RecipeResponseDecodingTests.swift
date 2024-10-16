//
//  RecipeResponseDecodingTests.swift
//  TakeHomeProjectTests
//
//  Created by Holly on 10/16/24.
//

import Testing
import Foundation

@testable
import TakeHomeProject

struct RecipeResponseDecodingTests {
    
    @Test func testSingleGood() async throws {
        let knownGood =
            """
            {
              "recipes": [
                {
                  "cuisine": "Malaysian",
                  "name": "Apam Balik",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                  "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                  "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                  "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                }
              ]
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(RecipeResponse.self, from: knownGood)
        
        #expect(decoded.recipes.count == 1)
        
        let first = decoded.recipes.first!
        
        #expect(first.cuisine == "Malaysian")
        #expect(first.name == "Apam Balik")
        #expect(first.photoUrlLarge?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(first.photoUrlSmall?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(first.sourceUrl?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(first.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(first.youtubeUrl?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    @Test func testEmptySet() async throws {
        let emptySet =
            """
            {
              "recipes": [
              ]
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(RecipeResponse.self, from: emptySet)
        
        #expect(decoded.recipes.count == 0)
    }
    
    @Test func testMalformed() async throws {
        let missingName =
            """
            {
              "recipes": [
                {
                  "cuisine": "Malaysian",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                  "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                  "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                  "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                }
              ]
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        #expect(throws: (any Error).self) {
            _ = try decoder.decode(RecipeResponse.self, from: missingName)
        }
    
    }
}
