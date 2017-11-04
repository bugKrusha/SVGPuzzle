//
//  PuzzleView.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/4/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import UIKit

class PuzzleView: UIView {
    var _class = ""
    
    init(_class: String, frame: CGRect, shapeLayer: CAShapeLayer) {
        self._class = _class
        super.init(frame: frame)
        self.layer.addSublayer(shapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
