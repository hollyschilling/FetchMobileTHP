//
//  MainViewModel.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation
import SwiftUICore

class MainViewModel: ObservableObject {
    
    enum State {
        case none
        case error
        case loaded
        case empty
        case loading
        case reloading
    }
    
    enum SortBy: String, CaseIterable {
        case cuisine = "Cuisine"
        case name = "Name"
    }
    
    struct ListSection {
        var heading: String
        var recipes: [Recipe]
    }


    @Published
    var state = State.none
    
    @Published
    var sorting = SortBy.name {
        didSet {
            if sorting == .name {
                sections = [ListSection(heading: "All Recipes", recipes: recipies)]
            } else {
                sections = Self.buildSections(recipes: recipies, keyPath: \.cuisine)
            }
        }
    }
    
    @Published
    var sections: [ListSection] = []

    @Published
    var error: (any Error)?

    private var recipies: [Recipe] = []
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    @MainActor
    func setValues(state: State, sections: [ListSection]? = nil, error: (any Error)? = nil) {
        self.state = state
        if let sections {
            self.sections = sections
        }
        self.error = error
    }
    
    func loadAsync() async {
        await self.setValues(state: state == .none ? .loading : .reloading)
        do {
            let recipes = try await self.dataManager.loadRecipes()
            let sortedRecipes = recipes.sorted { $0.name < $1.name }

            self.recipies = sortedRecipes
            
            guard recipes.count > 0  else {
                await setValues(state: .empty, sections: [])
                return
            }

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
