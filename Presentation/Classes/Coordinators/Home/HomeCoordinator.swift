//
//  HomeCoordinator.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import UIKit
import Domain

final class HomeCoordinator: Coordinator {
    
    private let dependencies: Dependencies
    weak var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
    private var childCoordinator: Coordinator?
    
    private var completion: (() -> Void)?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func start() {
        let homeVC = dependencies.homeViewControllerFactory.make(with: self)
        
        let navigationController = NavigationController(rootViewController: homeVC)
        
        rootViewController = navigationController
        
    }
    
    deinit {
        rootViewController = nil
    }
}

// MARK: LaunchRoutable
extension HomeCoordinator: HomeRouterDelegate {
    func showDetail(artObject: ArtObject) {
        guard let navigationController = rootViewController as? NavigationController else { return }
        
        var detailVC: UIViewController
        detailVC = dependencies.detailViewControllerFactory.make(with: self, artObject: artObject)
        
        navigationController.pushViewController(detailVC, animated: true)
    }
}

// MARK: LaunchRoutable
extension HomeCoordinator: DetailRouterDelegate {
    
    func dismissDetail() {
        guard let navigationController = rootViewController as? NavigationController else { return }
        
        navigationController.popViewController(animated: true)
    }
}
