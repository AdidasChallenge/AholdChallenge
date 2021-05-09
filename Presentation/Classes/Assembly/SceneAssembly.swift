//
//  SceneAssembly.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import Swinject
import SwinjectAutoregistration

public final class SceneAssembly: Assembly {
    
    // MARK: Lifecycle
    public init() { }
    
    let assemblies: [Assembly] = [
        LaunchAssembly(),
        HomeAssembly(),
        DetailAssembly()
    ]
    
    // MARK: Public methods
    public func assemble(container: Container) {
        assemblies.forEach({ $0.assemble(container: container) })
    }
}
