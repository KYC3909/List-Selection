//
//  ShapeProtocol.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation

protocol ShapeProtocol {
    
}

protocol SharpCurveShapeProtocol: ShapeProtocol {
    func drawSharpCurvedShape(_ direction: CurveShapeDirection)
}
