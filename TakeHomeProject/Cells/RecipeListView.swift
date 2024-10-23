//
//  RecipeListView.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation
import SwiftUI
import NukeUI

// (YouTube) play.square.fill
// (Internet) network

struct WebActionStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 17, *) {
            configuration.label
                .symbolEffect(.bounce.down, value: configuration.isPressed)
                .opacity(configuration.isPressed ? 0.3 : 1.0)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        } else {
            configuration.label
                .opacity(configuration.isPressed ? 0.3 : 1.0)
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
        
    }
}


struct RecipeListView: View {

    enum Action {
        case source(URL)
        case youtube(URL)
    }
        
    let recipe: Recipe
    
    var selectionAction: ((Action) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                LazyImage(url: recipe.photoUrlSmall) { state in
                    if let image = state.image {
                        image.resizable().aspectRatio(contentMode: .fill)
                    } else if state.error != nil {
                        Image("SadDoc")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                }
            }
            HStack(alignment: .center) {
                if let url = recipe.youtubeUrl {
                    Button {
                        selectionAction?(.youtube(url))
                    } label: {
                        Label("YouTube", systemImage: "play.square.fill")
                    }
                    .buttonStyle(WebActionStyle())
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    Spacer()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                Rectangle()
                    .frame(width: 1)
                    .foregroundStyle(Color.gray)
                if let url = recipe.sourceUrl {
                    Button {
                        selectionAction?(.source(url))
                    } label: {
                        Label("Source", systemImage: "network")
                    }
                    .buttonStyle(WebActionStyle())
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    Spacer()
                        .frame(minWidth: 0, maxWidth: .infinity)

                }
            }
            
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .buttonStyle(PlainButtonStyle())
    }
    
}

#Preview {
    List {
        RecipeListView(recipe: Recipe(
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            name: "Apam Balik",
            cuisine: "Malaysian",
            sourceUrl: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")!,
            youtubeUrl: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")!,
            photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!)
        )
        RecipeListView(recipe: Recipe(
            uuid: "599344f4-3c5c-4cca-b914-2210e3b3312f",
            name: "Apple & Blackberry Crumble",
            cuisine: "British",
            sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble")!,
            youtubeUrl: nil,
            photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!)
        )
        RecipeListView(recipe: Recipe(
            uuid: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
            name: "Apple Frangipan Tart",
            cuisine: "British",
            sourceUrl: nil,
            youtubeUrl: URL(string: "https://www.youtube.com/watch?v=4vhcOwVBDO4")!,
            photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")!)
        )
    }
}

