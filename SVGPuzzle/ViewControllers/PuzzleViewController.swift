//
//  PuzzleViewController.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/4/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    var model: PuzzleViewControllerPresentationModel!
    @IBOutlet weak var puzzleParentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            model = try PuzzleViewControllerPresentationModel(resource: "math-puzzle-4")
            addPuzzlesToView()
        } catch  {
            // Handle error here
            fatalError(error.localizedDescription)
        }
    }
    
    private func addPuzzlesToView() {
        for piece in model.pieces {
            let fit = ShapeTransformationUtility.fit(frame: piece.frame,
                                                     viewWidth: puzzleParentView.bounds.size.width)
            piece.shapeLayer.setAffineTransform(fit.t)
            
            let puzzleView = PuzzleView(_class: piece._class,
                                        frame: fit.frame,
                                        shapeLayer: piece.shapeLayer)

            addGestures(view: puzzleView)
            puzzleParentView.addSubview(puzzleView)
        }
    }
    
    private func addGestures(view: UIView) {
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotatePuzzle))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panPuzzle))
        view.addGestureRecognizer(rotate)
        view.addGestureRecognizer(pan)
    }
    
    @objc private func rotatePuzzle(sender: UIRotationGestureRecognizer) {
        guard let rotateView = sender.view as? PuzzleView else { return }
        let angle = sender.rotation
        let center = rotateView.center
        
        rotateView.transform = rotateView.transform.rotated(by: angle)
        model.transformationManagers[rotateView._class]?.updateTransform(type: .rotate(angle: angle, center: center))
        
        // reset
        sender.rotation = 0
    }
    
    @objc private func panPuzzle(sender: UIPanGestureRecognizer) {
        guard let panView = sender.view as? PuzzleView else { return }
        
        let translate = sender.translation(in: puzzleParentView)
        panView.center = CGPoint(x: panView.center.x + translate.x, y: panView.center.y + translate.y)
        
        model.transformationManagers[panView._class]?.updateTransform(type: .translate(tx: translate.x, ty: translate.y))
        
        // reset
        sender.setTranslation(CGPoint.zero, in: nil)
    }
}
