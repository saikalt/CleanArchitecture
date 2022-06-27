//
//  AppDIContainer.swift
//  CleanArchitecture
//
//  Created by Saikal Toichueva on 17/6/22.
//

import Foundation

final class AppDIContainer {

    func makeMainSceneDIContainer() -> MainSceneDIContainer {
        let dependencies = MainSceneDIContainer.Dependencies()
        return MainSceneDIContainer(dependencies: dependencies)
    }
}
