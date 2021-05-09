//
//  ArtObjectEntity.swift
//  Data
//
//  Created by Jesse Klijn on 08/05/2021.
//

import Foundation

struct ArtObjectEntity: Decodable {
    let id: String?
    let objectNumber: String?
    let title: String?
    let longTitle: String?
    let principalOrFirstMaker: String?
    let webImage: ImageEntity?
}
