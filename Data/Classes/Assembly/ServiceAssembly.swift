//
//  WorkerAssembly.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Domain

public final class ServiceAssembly: Assembly {
    
    public init() { }
    
    // MARK: Internal methods
    public func assemble(container: Container) {
        container.autoregister(CollectionWorker.self, initializer: CollectionService.init)
    }
}
