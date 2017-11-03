//
//  ShapeTransformationManager.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/1/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import Foundation
import CoreGraphics

enum TransformType {
    case rotate(angle: CGFloat, center: CGPoint)
    case translate(tx: CGFloat, ty: CGFloat)
}

class ShapeTransformationManager {
    private var transform = CGAffineTransform.identity
    
    /// A transformation attribute as required by the svg spec.
    var matrixAttribute: String {
        return "matrix(\(transform.a)" + ","
            + "\(transform.b)" + ","
            + "\(transform.c)" + ","
            + "\(transform.d)" + ","
            + "\(transform.tx)" + ","
            + "\(transform.ty)" + ")"
    }
    
    /// Each time a gesture is recognized, its transformation is passed here to be
    /// processed. In SVG space, rotations occur around the origin, so we must move
    /// the element to its origin. We then rotate it there, then translate it back since
    /// any subsequent tranform that is of type `translate`, doesn't require this.
    ///
    /// - Parameter type: Type of transformation.
    func updateTransform(type: TransformType) {
        switch type {
        case let .rotate(angle: angle, center: center):
            let rotation = CGAffineTransform
                .identity
                .translatedBy(x: center.x, y: center.y)
                .rotated(by: angle)
                .translatedBy(x: -center.x, y: -center.y)
            transform = transform.concatenating(rotation)
        case let .translate(tx: tx, ty: ty):
            transform = transform.concatenating(CGAffineTransform
                .identity
                .translatedBy(x: tx, y: ty))
        }
    }
}
