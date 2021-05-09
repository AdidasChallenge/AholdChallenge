//
//  HomePresenter.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Foundation
import Domain

final class HomePresenter {
    
    // MARK: private properties
    private weak var displayLogic: HomeDisplayLogic?
    
    private let productMapper: ArtObjectViewModelMapper
    
    init(productMapper: ArtObjectViewModelMapper) {
        self.productMapper = productMapper
    }
    
    func setup(with displayLogic: HomeDisplayLogic?) {
        self.displayLogic = displayLogic
    }
}

// MARK: - Responses
extension HomePresenter {
    func presentProducts(divider: Int, products: [ArtObject]) {
        displayLogic?.displayProducts(tiles: productMapper.map(divider: divider, artObjects: products))
    }
    
    func presentLoading(display: Bool) {
        displayLogic?.displayLoading(display: display)
    }
    
    func presentError(retryAction: (() -> Void)?) {
        displayLogic?.displayErrorView(viewModel: ErrorView.ViewModel(title: "search_error_description".localized(), retryAction: retryAction))
    }
}
