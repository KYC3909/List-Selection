//
//  CGRect+Utils.swift
//  ListSelection
//
//  Created by Krunal on 31/07/22.
//

import UIKit

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
