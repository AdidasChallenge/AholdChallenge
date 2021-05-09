//
//  HomeViewControllerFactory.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//  
//

import Swinject

// MARK: Factory
struct HomeViewControllerFactory {
    
    let interactorProvider: Provider<HomeInteractor>
    let presenterProvider: Provider<HomePresenter>
    
    func make(with router: HomeRouterDelegate) -> HomeViewController {
        let interactor = interactorProvider.instance
        let presenter = presenterProvider.instance
        let viewController = HomeViewController(interactor: interactor)
        
        interactor.setup(with: presenter, router: router)
        presenter.setup(with: viewController)
        
        return viewController
    }
}
