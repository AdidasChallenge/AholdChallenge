//
//  ArtObjectTile+ViewModel.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import UIKit

extension ArtObjectTile {
    struct ViewModel: Equatable {
        let id: String
        let thumbnail: String?
        let title: String
        let maker: String
    }
}
