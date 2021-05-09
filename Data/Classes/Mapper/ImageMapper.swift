//
//  ImageMapper.swift
//  Data
//
//  Created by Jesse Klijn on 08/05/2021.
//

import Foundation
import Domain

struct ImageEntityMapper {
    func map(entity: ImageEntity?) -> String? {
        guard let image = entity?.url
        else {
            return nil
        }
        
        return image
    }
}
