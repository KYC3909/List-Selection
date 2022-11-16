//
//  UIView + Extension.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue

              // If masksToBounds is true, subviews will be
              // clipped to the rounded corners.
              layer.masksToBounds = (newValue > 0)
        }
    }
    
    func enableDisableView(_ enabled: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.alpha = enabled ? 1 : 0
            self?.isUserInteractionEnabled = enabled
        } completion: { _ in }
    }
}

