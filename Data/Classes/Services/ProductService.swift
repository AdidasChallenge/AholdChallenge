//
//  ProductService.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Alamofire
import Domain

final class CollectionService: ProductWorker {
    private let collectionEntityMapper: CollectionEntityMapper
    
    private let productsBaseApiUrl: String = "https://data.rijksmuseum.nl/object-metadata/api/en/collection"
    
    // MARK: - Caching
    private var cache: [ArtObject]?
    
    init(productEntityMapper: ProductEntityMapper) {
        self.productEntityMapper = productEntityMapper
    }
    
    func getProducts(count: Int, searchTerm: String, completion: @escaping (Result<[ArtObject], Error>) -> Void) {
        let parameters: [String: Any] = [
            "key": "0fiuZFh4",
            "format": "json",
            "culture": "en",
            "p": "0",
            "p": "25",
            "q": searchTerm,
            
        ]
        
        AF.request(
            productsBaseApiUrl,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseJSON(completionHandler: { [weak self] response in
            
            switch response.result {
            case .success:
                guard let self = self, let data = response.data else { return }
                
                do {
                    let productEntities = try JSONDecoder().decode([CollectionEntity].self, from: data)
                    self.cache = productEntities.compactMap({ self.productEntityMapper.map(entity:$0) })
                    guard let products = self.cache else { return }
                    let filteredProducts = self.filterProducts(searchTerm: searchTerm, products: products)
                    completion(.success(filteredProducts))
                    
                } catch {
                    print("Error: \(error)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        })
    }
    
    func resetCache() {
        cache = nil
    }
}

// MARK: - Search filter
private extension CollectionService {
    func filterProducts(searchTerm: String, products: [ArtObject]) -> [ArtObject] {
        let searchTerm = searchTerm.lowercased()
        guard !searchTerm.isEmpty else { return products }
        
        return products.filter({
            guard searchTerm.contains($0.price) ||
                    searchTerm.contains($0.description) ||
                    searchTerm.contains($0.title) else {
                return false
            }
            
            return true
        })
    }
}
