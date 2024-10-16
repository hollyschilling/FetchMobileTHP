//
//  RecipeDecodingTests.swift
//  TakeHomeProjectTests
//
//  Created by Holly on 10/16/24.
//

import Testing
import Foundation

@testable
import TakeHomeProject


struct RecipeDecodingTests {
    
    @Test
    func knownGoodDecode() throws {
        let knownGood =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(Recipe.self, from: knownGood)
        #expect(decoded.cuisine == "Malaysian")
        #expect(decoded.name == "Apam Balik")
        #expect(decoded.photoUrlLarge?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(decoded.photoUrlSmall?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(decoded.sourceUrl?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(decoded.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(decoded.youtubeUrl?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    @Test
    func missingUuidDecode() throws {
        let missingUuid =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        #expect(throws: (any Error).self) {
            _ = try decoder.decode(Recipe.self, from: missingUuid)
        }
    }
    
    @Test
    func missingNameDecode() throws {
        let missingName =
            """
            {
                "cuisine": "Malaysian",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        #expect(throws: (any Error).self) {
            _ = try decoder.decode(Recipe.self, from: missingName)
        }
    }

    @Test
    func missingCuisineDecode() throws {
        let missingCuisine =
            """
            {
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """

            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
                
        #expect(throws: DecodingError.self) {
            _ = try decoder.decode(Recipe.self, from: missingCuisine)
        }
    }

    @Test
    func missingLargePhotoDecode() throws {
        let missingLargePhoto =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(Recipe.self, from: missingLargePhoto)
        #expect(decoded.cuisine == "Malaysian")
        #expect(decoded.name == "Apam Balik")
        #expect(decoded.photoUrlLarge == nil)
        #expect(decoded.photoUrlSmall?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(decoded.sourceUrl?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(decoded.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(decoded.youtubeUrl?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    @Test
    func missingSmallPhotoDecode() throws {
        let missingSmallPhoto =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(Recipe.self, from: missingSmallPhoto)
        #expect(decoded.cuisine == "Malaysian")
        #expect(decoded.name == "Apam Balik")
        #expect(decoded.photoUrlLarge?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(decoded.photoUrlSmall == nil)
        #expect(decoded.sourceUrl?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(decoded.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(decoded.youtubeUrl?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    func missingSourceDecode() throws {
        let missingSource =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(Recipe.self, from: missingSource)
        #expect(decoded.cuisine == "Malaysian")
        #expect(decoded.name == "Apam Balik")
        #expect(decoded.photoUrlLarge?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(decoded.photoUrlSmall?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(decoded.sourceUrl == nil)
        #expect(decoded.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(decoded.youtubeUrl?.absoluteString == "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
    
    func missingYoutubeDecode() throws {
        let missingYoutube =
            """
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
            """
            .data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decoded = try decoder.decode(Recipe.self, from: missingYoutube)
        #expect(decoded.cuisine == "Malaysian")
        #expect(decoded.name == "Apam Balik")
        #expect(decoded.photoUrlLarge?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        #expect(decoded.photoUrlSmall?.absoluteString == "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        #expect(decoded.sourceUrl?.absoluteString == "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        #expect(decoded.uuid == "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        #expect(decoded.youtubeUrl == nil)
    }
}
