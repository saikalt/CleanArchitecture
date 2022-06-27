//
//  AppFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by Saikal Toichueva on 17/6/22.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    // MARK: - Start point of app
    func start() {
        let moviesSceneDIContainer = appDIContainer.makeMainSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMainFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
