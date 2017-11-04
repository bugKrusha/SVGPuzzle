//
//  SVGDocumentManger.swift
//  SVGPuzzle
//
//  Created by Jon-Tait Beason on 11/2/17.
//  Copyright © 2017 Jon-Tait Beason. All rights reserved.
//

import Foundation
import SwiftSVG

class SVGDocumentManager {
    let document: GDataXMLDocument
    private var pathElements: [GDataXMLElement] = []
    
    init(data: Data) throws {
        document = try GDataXMLDocument(data: data, options: 0)
        extractPathElements()
    }
    
    private func extractPathElements() {
        guard
            let root = document.rootElement(),
            let pathElements = root.elements(forName: Attributes.path) as? [GDataXMLElement]
            else { return }
        
        self.pathElements = pathElements
    }
    
    /// Goes thru the svg file, extract the path elements and convert them to PuzzlePieces.
    ///
    /// - Returns: Extracted puzzle pieces
    /// - Throws: Throws an svg processing error if one should occur.
    func getPuzzlePieces() throws -> [PuzzlePiece] {
        var pieces: [PuzzlePiece] = []
        for element in pathElements {
            guard
                let dPath = element.attribute(forName: Attributes.dPath).stringValue(),
                let _class = element.attribute(forName: Attributes._class).stringValue()
                else { throw SVGProcessingError.attribute }
            
            pieces.append(PuzzlePiece(dPath: dPath, _class: _class))
        }
        return pieces
    }
}
