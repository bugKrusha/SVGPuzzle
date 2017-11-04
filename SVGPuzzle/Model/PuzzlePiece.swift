//
//  PuzzlePiece.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/2/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import Foundation
import SwiftSVG

class PuzzlePiece {
    let dPath: String
    let _class: String
    let shapeLayer: CAShapeLayer
    
    init(dPath: String, _class: String) {
        self.dPath = dPath
        self._class = _class
        self.shapeLayer = CAShapeLayer(pathString: dPath)
    }
}
