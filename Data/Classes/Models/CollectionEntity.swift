//
//  ProductEntity.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation

struct CollectionEntity: Decodable {
    let elapsedMilliseconds: Int?
    let count: Int?
    let artObjects: [ArtObjectEntity]?
}
