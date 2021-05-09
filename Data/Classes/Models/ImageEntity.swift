//
//  ImageEntity.swift
//  Data
//
//  Created by Jesse Klijn on 08/05/2021.
//

import Foundation

struct ImageEntity: Decodable {
    let guid: String?
    let width: Int?
    let height: Int?
    let url: String?
}
