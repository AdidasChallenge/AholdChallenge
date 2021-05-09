//
//  ProductService.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Alamofire
import Domain

final class CollectionService: CollectionWorker {
    
    private let collectionEntityMapper: CollectionEntityMapper
    private let productsBaseApiUrl: String = "https://www.rijksmuseum.nl/api/en/collection"
    
    init(collectionEntityMapper: CollectionEntityMapper) {
        self.collectionEntityMapper = collectionEntityMapper
    }
    
    func getCollection(divider: Int, count: Int, searchTerm: String, completion: @escaping (Result<[ArtObject], Error>) -> Void) {
        let pageCount = count / divider
        
        let parameters: [String: Any] = [
            "key": "0fiuZFh4",
            "format": "json",
            "culture": "en",
            "p": "\(pageCount)",
            "ps": "\(divider)",
            "q": searchTerm,
            "imgonly": "true"
        ]
        AF.request(
            productsBaseApiUrl,
            parameters: parameters).responseJSON(completionHandler: { [weak self] response in
            
            switch response.result {
            case .success:
                guard let self = self, let data = response.data else { return }
                
                do {
                    let collectionEntity = try JSONDecoder().decode(CollectionEntity.self, from: data)
                    guard let artObjects = self.collectionEntityMapper.map(entity: collectionEntity) else {
                        completion(.success([]))
                        return
                    }
                    completion(.success(artObjects))
                } catch {
                    print("Error: \(error)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })
    }
}
