//
//  ContentView.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject
    var vm: MainViewModel

    init(loader: UrlLoader) {
        let dm = DataManager(urlLoader: loader)
        vm = MainViewModel(dataManager: dm)
    }

    
    init() {
        let loader = UrlSessionLoader(defaultCachePolicy: .reloadIgnoringLocalAndRemoteCacheData, defaultTimeout: 5)
        let dm = DataManager(urlLoader: loader)
        vm = MainViewModel(dataManager: dm)
    }
    
    var body: some View {
        VStack {
            switch vm.state {
            case .none:
                EmptyView()
            case .empty:
                empty
            case .error:
                error
            case .loading:
                loading
            case .reloading:
                loading
            case .loaded:
                list
            }
        }
        .onAppear {
//            vm.state = .empty
            if vm.state == .none {
                Task {
                    await vm.loadAsync()
                }
            }
        }
        .toolbar {
            Picker("Sorting", selection: $vm.sorting) {
                ForEach(MainViewModel.SortBy.allCases, id: \.rawValue) { sort in
                    Text(sort.rawValue)
                        .tag(sort)
                }
            }
            .pickerStyle(.segmented)

        }
    }
    
    var list: some View {
        List {
            ForEach(vm.sections, id: \.heading) { section in
                Section(header: Text(section.heading)) {
                    ForEach(section.recipes) { recipe in
                        RecipeListView(recipe: recipe)
                    }
                }
                .headerProminence(.increased)
            }
        }
        .refreshable {
            Task {
                await vm.loadAsync()
            }
        }
    }
    
    var empty: some View {
        VStack(spacing: 20) {
            Text("No Recipes to Show")
                .font(.largeTitle)
            Button {
                Task {
                    await self.vm.loadAsync()
                }
            } label: {
                Label("Reload", systemImage: "arrow.trianglehead.clockwise")
                    .font(.title)
            }

        }
    }
    
    var error: some View {
        VStack(spacing: 20) {
            Label("No Internet", systemImage: "network.slash")
                .labelStyle(.iconOnly)
                .font(.largeTitle)
            Text("An error occurred loading the content. Check your connection and try again.")
                .font(.title2)
            Button {
                Task {
                    await self.vm.loadAsync()
                }
            } label: {
                Label("Reload", systemImage: "arrow.trianglehead.clockwise")
                    .font(.title)
            }
        }
    }
    
    var loading: some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
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
        let loader = PredictableLoader(result: .success(validData), delay: .milliseconds(500))
        ContentView(loader: loader)
    }
}
