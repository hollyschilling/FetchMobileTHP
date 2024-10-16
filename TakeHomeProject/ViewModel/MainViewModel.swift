//
//  MainViewModel.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation
import SwiftUICore

let contentUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

class ListViewModel: ObservableObject {
    
    enum State {
        case none
        case error
        case loaded
        case empty
        case loading
        case reloading
    }
    
    enum SortBy {
        case cuisine, name
    }
    
    struct ListSection {
        var heading: String
        var recipes: [Recipe]
    }


    @Published
    var state = State.none
    
    @Published
    var sorting = SortBy.name
    
    @Published
    var sections: [ListSection] = []

    @Published
    var error: (any Error)?

    let loader: UrlLoader
    
    init(loader: UrlLoader) {
        self.loader = loader
    }
    
    @MainActor
    func setValues(state: State, sections: [ListSection]? = nil, error: (any Error)? = nil) {
        self.state = state
        if let sections {
            self.sections = sections
        }
        self.error = error
    }
    
    func beginLoad() {
        
        Task {
            await self.setValues(state: state == .none ? .loading : .reloading)
            do {
                let response: RecipeResponse = try await self.loader.fetchJsonAsync(url: contentUrl)

                guard response.recipes.count > 0  else {
                    await setValues(state: .empty, sections: [])
                    return
                }

                let sortedRecipes = response.recipes.sorted { $0.name < $1.name }
                switch self.sorting {
                case .cuisine:
                    let sections = Self.buildSections(recipes: sortedRecipes, keyPath: \.cuisine)
                    await self.setValues(state: .loaded, sections: sections)

                case .name:
                    let singleSection = ListSection(heading: "All Recipes", recipes: sortedRecipes)
                    await self.setValues(state: .loaded, sections: [singleSection])
                }
            }
            catch {
                await self.setValues(state: .error, sections: [], error: error)
            }
        }
    }
    
    static func buildSections(recipes: [Recipe], keyPath: KeyPath<Recipe, String>) -> [ListSection] {
        var sections: [String: ListSection] = [:]
        
        for recipe in recipes {
            let identifier = recipe[keyPath: keyPath]
            var section = sections[identifier] ?? ListSection(heading: identifier, recipes: [])
            section.recipes.append(recipe)
            sections[identifier] = section
        }
        
        let allSections = sections.values
        return allSections.sorted { (lhs, rhs) in
            return lhs.heading < rhs.heading
        }
    }
}
