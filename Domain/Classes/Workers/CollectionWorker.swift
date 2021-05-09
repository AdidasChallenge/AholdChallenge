//
//  CollectionWorker.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation

public protocol CollectionWorker: AnyObject {
    func getCollection(divider: Int, count: Int, searchTerm: String, completion: @escaping (Result<[ArtObject], Error>) -> Void)
}
