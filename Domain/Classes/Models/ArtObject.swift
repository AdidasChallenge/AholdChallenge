//
//  Product.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation

public struct ArtObject {
    public let id: String
    public let title: String
    public let longTitle: String
    public let maker: String
    public let image: String?
    
    public init(
        id: String,
        title: String,
        longTitle: String,
        maker: String,
        image: String?
        ) {
        self.id = id
        self.title = title
        self.longTitle = longTitle
        self.maker = maker
        self.image = image
    }
}
