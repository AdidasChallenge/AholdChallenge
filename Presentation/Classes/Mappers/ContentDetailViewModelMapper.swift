//
//  ContentDetailViewModelMapper.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 06/05/2021.
//

import Foundation
import Domain

struct ContentDetailViewModelMapper {
    func map(artObject: ArtObject) -> DetailContentView.ViewModel {
        .init(
            id: artObject.id,
            thumbnail: artObject.image,
            title: artObject.longTitle,
            maker: artObject.maker
        )
    }
}
