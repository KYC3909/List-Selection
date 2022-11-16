//
//  GradientView.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import Foundation
import UIKit

final class GradientView: UIView {
    private let gradient = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    private func setupView() {
        gradient.colors = [UIColor(named: "GradientColor1")!.cgColor,
                           UIColor(named: "GradientColor2")!.cgColor ]
        gradient.locations = [0,1]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
