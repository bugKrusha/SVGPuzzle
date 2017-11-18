//
//  PuzzleViewControllerPresentationModel.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/4/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import Foundation

class PuzzleViewControllerPresentationModel {
    let documentManager: SVGDocumentManager
    private(set) var transformationManagers: [String: ShapeTransformationManager] = [:]
    private(set) var pieces: [PuzzlePiece] = []
    
    init(resource: String) throws {
        documentManager = try SVGDocumentManager(resource: resource)
        pieces = try documentManager.getPuzzlePieces()
        createTransformManagers()
    }
    
    private func createTransformManagers() {
        for piece in pieces {
            transformationManagers[piece._class] = ShapeTransformationManager(_class: piece._class)
        }
    }
}
