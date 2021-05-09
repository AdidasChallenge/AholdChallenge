//
//  DetailViewControllerFactory.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Swinject
import Domain

// MARK: Factory
struct DetailViewControllerFactory {
    
    let interactorProvider: Provider<DetailInteractor>
    let presenterProvider: Provider<DetailPresenter>
    
    func make(with router: DetailRouterDelegate, artObject: ArtObject) -> DetailViewController {
        let interactor = interactorProvider.instance
        let presenter = presenterProvider.instance
        let viewController = DetailViewController(interactor: interactor)
        
        interactor.setup(with: presenter, router: router, artObject: artObject)
        presenter.setup(with: viewController)
        
        return viewController
    }
}
