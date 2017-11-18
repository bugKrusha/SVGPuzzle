//
//  TransformationUtility.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/4/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import Foundation
import CoreGraphics

struct ShapeTransformationUtility {
    /// Given the frame of a path, we need to fit that frame to the display device screen. We first
    /// scale it down using a calculated scale. This frame will be used to create the display view.
    /// We then calculate the transform that needs to be applied to the path/shapelayer before it
    /// it is added to the view. The scale is the same but first we have to translate it to the origin
    /// of the newly fitted frame so the path is within the views visible frame.
    ///
    /// - Parameters:
    ///   - frame: Original frame of the path/shape layer.
    ///   - viewWidth: Width of the parent view to which the views holding the paths will be added.
    /// - Returns: Fitted frame for the view and the transform for the layer.
    static func fit(frame: CGRect, viewWidth: CGFloat) -> (frame: CGRect, t: CGAffineTransform) {
        let scale = viewWidth / Constants.svgWidth
        let fittedFrame = frame.applying(CGAffineTransform(scaleX: scale, y: scale))
        
        let t = CGAffineTransform
            .identity
            .translatedBy(x: -fittedFrame.origin.x, y: -fittedFrame.origin.y)
            .scaledBy(x: scale, y: scale)
        
        return (frame: fittedFrame, t: t)
    }
}
