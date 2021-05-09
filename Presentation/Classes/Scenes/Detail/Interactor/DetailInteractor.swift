//
//  DetailInteractor.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Domain

final class DetailInteractor {
    
    // MARK: Private properties
    private var presenter: DetailPresenter?
    private var router: DetailRouterDelegate?
    
    private var artObject: ArtObject?
    
    // MARK: Lifecycle
    init() { }
    
    // MARK: Internal methods
    func setup(with presenter: DetailPresenter,
               router: DetailRouterDelegate,
               artObject: ArtObject) {
        self.presenter = presenter
        self.router = router
        self.artObject = artObject
    }
}

// MARK: - Requests
extension DetailInteractor {
    
    func handleInitialize() {
        guard let artObject = artObject else { return }
        presenter?.presentDetail(artObject: artObject)
        
    }
    
    func didTapBack() {
        router?.dismissDetail()
    }
}
