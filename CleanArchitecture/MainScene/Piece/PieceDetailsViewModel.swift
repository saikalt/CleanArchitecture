//
//  PieceViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import Foundation

protocol PieceDetailsViewModel: AnyObject {
    var piece: PieceDetails { get set }
    var saveHandle: ((PieceDetails) -> Void) { get set }

    func save(piece: PieceDetails)
}

class PieceDetailsViewModelImpl: PieceDetailsViewModel {
    var saveHandle: ((PieceDetails) -> Void)

    var piece: PieceDetails

    func save(piece: PieceDetails) {
        saveHandle(piece)
    }
    
    init(piece: PieceDetails, saveHandle: @escaping ((PieceDetails) -> Void)) {
        self.piece = piece
        self.saveHandle = saveHandle
    }
}
