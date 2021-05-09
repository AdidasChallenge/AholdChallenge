//
//  ArtObjectEntityMapper.swift
//  Data
//
//  Created by Jesse Klijn on 08/05/2021.
//

import Foundation
import Domain

struct ArtObjectEntityMapper {
    
    private let imageMapper: ImageEntityMapper
    
    init(imageMapper: ImageEntityMapper) {
        self.imageMapper = imageMapper
    }
    
    func map(entity: ArtObjectEntity) -> ArtObject? {
        guard let id = entity.id,
              let title = entity.title,
              let longTitle = entity.longTitle,
              let principalOrFirstMaker = entity.principalOrFirstMaker
        else {
            return nil
        }
        
        return .init(
            id: id,
            title: title,
            longTitle: longTitle,
            maker: principalOrFirstMaker,
            image: imageMapper.map(entity: entity.webImage)
        )
    }
}
