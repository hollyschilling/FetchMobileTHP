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


struct RecipeListView: View {

    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                LazyImage(url: recipe.photoUrlSmall)
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
                Button {
                    
                } label: {
                    Label("YouTube", systemImage: "play.square.fill")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                Rectangle()
                    .frame(width: 1)
                    .foregroundStyle(Color.gray)
                Button {
                    
                } label: {
                    Label("Source", systemImage: "network")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
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
    }
}

