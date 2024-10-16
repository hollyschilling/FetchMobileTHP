//
//  MainViewModelTests.swift
//  TakeHomeProjectTests
//
//  Created by Holly on 10/16/24.
//

import Testing
import Foundation

@testable
import TakeHomeProject


struct MainViewModelTests {
    let validData =
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
            },
            {
              "cuisine": "British",
              "name": "Apple & Blackberry Crumble",
              "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
              "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
              "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
              "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
              "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            }
          ]
        }
        """
        .data(using: .utf8)!
    
    let invalidData =
        """
        {
          "recipes": [
            {
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
    
    
    @Test
    func loadValidByName() async throws {

        let loader = PredictableLoader(result: .success(validData))
        let dataManager = DataManager(urlLoader: loader)
        let vm = MainViewModel(dataManager: dataManager)
        vm.sorting = .name
        #expect(vm.state == .none)
        await vm.loadAsync()
        #expect(vm.state == .loaded)
        #expect(vm.sections.count == 1)
        #expect(vm.sections[0].recipes.count == 2)
    }

    @Test
    func loadValidByCuisine() async throws {

        let loader = PredictableLoader(result: .success(validData))
        let dataManager = DataManager(urlLoader: loader)
        let vm = MainViewModel(dataManager: dataManager)
        vm.sorting = .cuisine
        #expect(vm.state == .none)
        await vm.loadAsync()
        #expect(vm.state == .loaded)
        #expect(vm.sections.count == 2)
        #expect(vm.sections[0].heading ==  "British")
        #expect(vm.sections[0].recipes.count == 1)
        #expect(vm.sections[1].heading ==  "Malaysian")
        #expect(vm.sections[1].recipes.count == 1)
    }

    @Test
    func loadInvalid() async throws {

        let loader = PredictableLoader(result: .success(invalidData))
        let dataManager = DataManager(urlLoader: loader)
        let vm = MainViewModel(dataManager: dataManager)
        vm.sorting = .cuisine
        #expect(vm.state == .none)
        await vm.loadAsync()
        #expect(vm.state == .error)
        #expect(vm.sections.count == 0)
    }
    
    @Test
    func changeSort() async throws {
        let loader = PredictableLoader(result: .success(validData))
        let dataManager = DataManager(urlLoader: loader)
        let vm = MainViewModel(dataManager: dataManager)
        vm.sorting = .name
        #expect(vm.state == .none)
        await vm.loadAsync()
        #expect(vm.state == .loaded)
        #expect(vm.sections.count == 1)
        #expect(vm.sections[0].recipes.count == 2)
        
        vm.sorting = .cuisine
        #expect(vm.state == .loaded)
        #expect(vm.sections.count == 2)
        #expect(vm.sections[0].heading ==  "British")
        #expect(vm.sections[0].recipes.count == 1)
        #expect(vm.sections[1].heading ==  "Malaysian")
        #expect(vm.sections[1].recipes.count == 1)

        vm.sorting = .name
        #expect(vm.state == .loaded)
        #expect(vm.sections.count == 1)
        #expect(vm.sections[0].recipes.count == 2)

    }

}
