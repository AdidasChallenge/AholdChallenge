//
//  DetailPresenter.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Foundation
import Domain

final class DetailPresenter {
    
    // MARK: private properties
    private weak var displayLogic: DetailDisplayLogic?
    
    private let contentDetailViewModelMapper: ContentDetailViewModelMapper
    
    init(
        contentDetailViewModelMapper: ContentDetailViewModelMapper
    ) {
        self.contentDetailViewModelMapper = contentDetailViewModelMapper
    }
    
    func setup(with displayLogic: DetailDisplayLogic?) {
        self.displayLogic = displayLogic
    }
}

// MARK: - Responses
extension DetailPresenter {
    
    func presentDetail(artObject: ArtObject) {
        displayLogic?.presentDetail(viewModel: contentDetailViewModelMapper.map(artObject: artObject))
    }
    func presentError(retryAction: (() -> Void)?) {
        displayLogic?.presentError(retryAction: retryAction)
    }
}
