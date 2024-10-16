//
//  DataManager.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation

struct DataManager {
    static let recipeUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    let urlLoader: UrlLoader
    let jsonDecoder: JSONDecoder
    
    init(urlLoader: UrlLoader) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = decoder
        
        self.urlLoader = urlLoader

    }
    
    func loadRecipes() async throws -> [Recipe] {
        let data = try await urlLoader.fetchAsync(url: Self.recipeUrl)
        let response = try jsonDecoder.decode(RecipeResponse.self, from: data)
        return response.recipes
    }
}
