//
//  CollectionEntityMapper.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Domain

struct CollectionEntityMapper {
    
    private let artObjectMapper: ArtObjectEntityMapper
    
    init(artObjectMapper: ArtObjectEntityMapper) {
        self.artObjectMapper = artObjectMapper
    }
    
    func map(entity: CollectionEntity) -> [ArtObject]? {
        guard let artObjects = entity.artObjects, !artObjects.isEmpty else {
            return nil
        }
        
        return artObjects.compactMap({ artObject in
            return artObjectMapper.map(entity: artObject)
        })
    }
}
