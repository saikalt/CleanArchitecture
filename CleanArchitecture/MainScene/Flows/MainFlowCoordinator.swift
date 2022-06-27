//
//  MainFlowCoordinator.swift
//  test-task-halbestunde
//
//  Created by Saikal Toichueva on 17/6/22.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorDependencies {
    func makePiecesViewController(actions: PiecesViewModelActions) -> PiecesViewController
    func makePieceDetailsViewController(piece: PieceDetails,
                                        saveHandle: @escaping (PieceDetails) -> Void) -> PieceDetailsViewController
}

class MainFlowCoordinator {

    // MARK: - Private properties for entire flow

    private weak var navigationController: UINavigationController?
    private let dependecies: MainFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependecies: MainFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependecies = dependecies
    }

    // MARK: - Start point for flow

    func start() {
        let actions = PiecesViewModelActions(showPieceDetails: showPieceDetails,
                                             popViewController: popViewController,
                                             addNewPiece: addNewPiece)
        let viewController = dependecies.makePiecesViewController(actions: actions)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    private func addNewPiece() {
        let alertController = UIAlertController(title: "Sorry",
                                                message: "The feature is temporarily unavailable",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
            self?.navigationController?.dismiss(animated: true)
        }))

        navigationController?.present(alertController, animated: true)
    }

    private func showPieceDetails(piece: PieceDetails, updatedPiece: @escaping (PieceDetails) -> Void) {
        let controller = dependecies.makePieceDetailsViewController(piece: piece, saveHandle: updatedPiece)
        navigationController?.pushViewController(controller, animated: true)
    }
}


