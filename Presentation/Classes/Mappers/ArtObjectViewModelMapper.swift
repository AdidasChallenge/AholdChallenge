//
//  ArtObjectViewModelMapper.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Domain

struct ArtObjectViewModelMapper {
    
    func map(divider: Int, artObjects: [ArtObject]) -> [[ArtObjectTile.ViewModel]] {
        
        artObjects.map({
            ArtObjectTile.ViewModel(
                id: $0.id,
                thumbnail: $0.image,
                title: $0.title,
                maker: $0.maker
            )
        }).chunked(into: divider)
    }
}
