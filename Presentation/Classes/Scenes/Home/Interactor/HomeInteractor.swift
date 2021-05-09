//
//  HomeInteractor.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Domain

enum LoadingStates {
    case ready
    case loading
    case bottom
}

final class HomeInteractor {
    
    // MARK: Private properties
    private var presenter: HomePresenter?
    private var router: HomeRouterDelegate?
    private let collectionWorker: CollectionWorker
    
    private let itemsPerPage: Int = 10
    private let offsetCriteria: Int = 5
    private var searchTerm: String = ""
    
    private var loadingState: LoadingStates = .ready
    
    private var artObjects: [ArtObject] = []
    
    // MARK: Lifecycle
    init(collectionWorker: CollectionWorker) {
        self.collectionWorker = collectionWorker
    }
    
    // MARK: Internal methods
    func setup(with presenter: HomePresenter, router: HomeRouterDelegate) {
        self.presenter = presenter
        self.router = router
    }
}

// MARK: - Requests
extension HomeInteractor {
    
    func handleInitialize() {
        getProducts(searchTerm: searchTerm)
    }
    
    func didTapProduct(productId: String) {
        guard let artObject = artObjects.first(where: {
                $0.id == productId
              }) else {
            return
        }
        
        router?.showDetail(artObject: artObject)
    }
    
    func searchTextDidChange(searchTerm: String) {
        guard searchTerm != self.searchTerm else { return }
        artObjects = []
        if loadingState == .bottom { loadingState = .ready }
        self.searchTerm = searchTerm
        getProducts(searchTerm: searchTerm)
    }
    
    /// Calculates whether the paging functionality needs to request another page to be loaded. Based on which cell is displayed and in which section.
    /// If the offset criteria is met, we know we have to load another page.
    func willDisplayCell(section: Int, offset: Int) {
        guard artObjects.count - ((section*itemsPerPage) + offset) == offsetCriteria,
              loadingState == .ready
        else {
            return
        }
        
        getProducts(searchTerm: searchTerm)
    }
}

// MARK: - Products
private extension HomeInteractor {
    func getProducts(searchTerm: String) {
        
        guard loadingState == .ready else { return }
        loadingState = .loading
        
        presenter?.presentLoading(display: true)
        collectionWorker.getCollection(divider: itemsPerPage, count: artObjects.count, searchTerm: searchTerm, completion: { [weak self] response in
            guard let self = self else { return }
            self.loadingState = .ready
            switch response {
            case .success(let artObjects):
                self.artObjects.append(contentsOf: artObjects)
                self.presenter?.presentProducts(divider: self.itemsPerPage, products: self.artObjects)
                
                // Paging functionality, if the response does not return the expected amount, we know we have hit the bottom of the list. So no more paging will be requested.
                guard artObjects.count != self.itemsPerPage else { return }
                self.loadingState = .bottom
                
            case .failure:
                self.presenter?.presentError(retryAction: {
                    self.getProducts(searchTerm: searchTerm)
                })
            }
        })
    }
}
