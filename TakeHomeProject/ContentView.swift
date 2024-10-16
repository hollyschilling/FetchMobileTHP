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
                        Text(recipe.name)
                    }
                }
                .headerProminence(.increased)
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
        ContentView()
    }
}
