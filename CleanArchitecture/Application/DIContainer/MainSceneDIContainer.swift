//
//  CompositionDIContainer.swift
//  test-task-halbestunde
//
//  Created by Saikal Toichueva on 17/6/22.
//

import Foundation
import UIKit

final class MainSceneDIContainer {

    // MARK: - Dependencies
    struct Dependencies {}

    var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Main Scene
    func makeMainFlowCoordinator(navigationController: UINavigationController) -> MainFlowCoordinator {
        return MainFlowCoordinator(navigationController: navigationController, dependecies: self)
    }

    func makePiecesViewController(actions: PiecesViewModelActions) -> PiecesViewController {
        let viewModel: PiecesViewModel = PiecesViewModelImpl(actions: actions)
        let controller = PiecesViewController(viewModel: viewModel)
        return controller
    }

    func makePieceDetailsViewController(piece: PieceDetails,
                                        saveHandle: @escaping (PieceDetails) -> Void) -> PieceDetailsViewController {
        let viewModel: PieceDetailsViewModel = PieceDetailsViewModelImpl(piece: piece, saveHandle: saveHandle)
        let controller = PieceDetailsViewController(viewModel: viewModel)
        return controller
    }
}

extension MainSceneDIContainer: MainFlowCoordinatorDependencies {}
