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
    private let path: UIBezierPath
    let dPath: String
    let _class: String
    let shapeLayer: CAShapeLayer
    
    var frame: CGRect {
        return path.bounds
    }
    
    init(dPath: String, _class: String) {
        self.dPath = dPath
        self._class = _class
        self.path = UIBezierPath(pathString: dPath)
        self.shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.backgroundColor = UIColor.blue.cgColor
    }
}
