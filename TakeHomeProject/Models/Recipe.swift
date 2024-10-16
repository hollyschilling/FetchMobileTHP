//
//  Recipe.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation


struct Recipe: Decodable {
    
    var uuid: String
    var name: String
    var cuisine: String
    var sourceUrl: URL?
    var youtubeUrl: URL?
    var photoUrlSmall: URL?
    var photoUrlLarge: URL?
    
}

extension Recipe: Identifiable {
    var id: String { uuid }
}
