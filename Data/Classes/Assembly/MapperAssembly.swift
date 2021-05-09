//
//  MapperAssembly.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 05/05/2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import Domain

public final class MapperAssembly: Assembly {
    
    public init() { }
    
    // MARK: Internal methods
    public func assemble(container: Container) {
        
        // MARK: - Entity mappers
        container.autoregister(CollectionEntityMapper.self, initializer: CollectionEntityMapper.init)
        container.autoregister(ImageEntityMapper.self, initializer: ImageEntityMapper.init)
        container.autoregister(ArtObjectEntityMapper.self, initializer: ArtObjectEntityMapper.init)
    }
}
