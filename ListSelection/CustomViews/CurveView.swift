//
//  CurveView.swift
//  ListSelection
//
//  Created by Krunal on 30/07/22.
//

import UIKit


extension CurveView: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.finalShapeColor()
        }
    }
}

final class CurveView: UIView, SharpCurveShapeProtocol {
    
    private var direction:CurveShapeDirection! = .BottomRightCornerSharpAngle
    var shape: CAShapeLayer?
    var opaqueShape: CAShapeLayer?

    let duration : Double = 1
    
    override init(frame: CGRect) { super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder)
    }
    override func layoutSubviews() { super.layoutSubviews()
        self.shape?.removeAllAnimations()
        self.opaqueShape?.removeAllAnimations()
        self.changeShape()
    }
    private func initialConfig() {
        self.backgroundColor = .clear
        
        shape?.removeAllAnimations()
        shape?.removeFromSuperlayer()
        shape = CAShapeLayer()
        shape?.lineWidth = 2
        shape?.strokeColor = UIColor.orange.cgColor
        shape?.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(shape!, at: 0)
        
        opaqueShape?.removeAllAnimations()
        opaqueShape?.removeFromSuperlayer()
        opaqueShape = CAShapeLayer()
        opaqueShape?.opacity = 0
        opaqueShape?.fillColor = UIColor.black.cgColor
        self.layer.insertSublayer(opaqueShape!, at: 0)
        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        initialConfig()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.drawSharpCurvedShape(self.direction)
        }
    }
    private func changeShape() {
        shape?.fillColor = UIColor.clear.cgColor
        opaqueShape?.fillColor = UIColor.black.cgColor
    }
    private func finalShapeColor() {
        shape?.fillColor = UIColor.black.cgColor
        opaqueShape?.fillColor = UIColor.black.cgColor
    }
    func drawSharpCurvedShape(_ direction: CurveShapeDirection){
        // Assign Direction Enum Value
        self.direction = direction
        CATransaction.begin()
        
        initialConfig()
        
        let path = drawPath()
        shape?.path = path.cgPath
        opaqueShape?.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        let animation1 = CABasicAnimation(keyPath: "opacity")
        animation1.duration = duration
        animation1.fromValue = 0
        animation1.toValue = 1
        animation1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        opaqueShape?.opacity = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.opaqueShape?.opacity = 1
        } completion: { _ in }

        CATransaction.setCompletionBlock{ [weak self] in
            print("Animation completed")
            self?.finalShapeColor()
        }
        
        self.shape?.add(animation, forKey: "animationStrokeEnd")
        self.opaqueShape?.add(animation1, forKey: "animationOpacity")
        
        CATransaction.commit()

    }
    
    func animation(){
        CATransaction.begin()
        
        let layer : CAShapeLayer = CAShapeLayer()
        layer.strokeColor = UIColor.purple.cgColor
        layer.lineWidth = 3.0
        layer.fillColor = UIColor.clear.cgColor
        
        let path : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.size.width + 2, height: self.frame.size.height + 2), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5.0, height: 0.0))
        layer.path = path.cgPath
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        animation.duration = 7.0
        
        CATransaction.setCompletionBlock{ [weak self] in
            print("Animation completed")
        }
        
        layer.add(animation, forKey: "myStroke")
        CATransaction.commit()
        self.layer.addSublayer(layer)
    }
    
    
    private func drawPath() -> UIBezierPath{
        let drawablePath = UIBezierPath()
        
        // Get View Width & Height
        let width = frame.width
        let height = frame.height
        
        var controlPoint1 = CGPoint(x: CGFloat(width * 0.24),
                                    y: CGFloat(0))
        var controlPoint2 = CGPoint(x: CGFloat(width * 0.68),
                                    y: CGFloat(height * 0.09))
        
        // Directions
        switch self.direction {
        case .TopRightCornerSharpAngle:
            drawAtTopRightCornerSharpAngle(drawablePath, height, &controlPoint1, width, &controlPoint2)
            break
            
            
        case .TopLeftCornerSharpAngle:
            drawAtTopLeftCornerSharpAngle(drawablePath, width, height, &controlPoint1, &controlPoint2)
            break
            
            
        case .BottomRightCornerSharpAngle:
            drawAtBottomRightCornerSharpAngle(drawablePath, height, &controlPoint1, width, &controlPoint2)
            break
            
            
        case .BottomLeftCornerSharpAngle:
            drawAtBottomLeftCornerSharpAngle(drawablePath, height, &controlPoint1, width, &controlPoint2)
            break
            
            
        case .none:
            break
        }
        
        drawablePath.close()
        return drawablePath
    }
    
    
    
    // BottomRightCornerSharpAngle
    private func drawAtBottomRightCornerSharpAngle(_ drawablePath: UIBezierPath, _ height: CGFloat, _ controlPoint1: inout CGPoint, _ width: CGFloat, _ controlPoint2: inout CGPoint) {
        // Move Pointer to the specific Location
        drawablePath.move(to: CGPoint(x: 0,
                                      y: CGFloat(height * 0.28)))
        
        // Create 2 Control Points which are responsible for generating Curve
        controlPoint1 = CGPoint(x: CGFloat(width * 0.24),
                                y: CGFloat(0))
        controlPoint2 = CGPoint(x: CGFloat(width * 0.68),
                                y: CGFloat(height * 0.09))
        
        // Add Curve using Control Points
        drawablePath.addCurve(to:CGPoint(x: width,
                                         y: height ),
                              controlPoint1: controlPoint1,
                              controlPoint2: controlPoint2)
        
        
        
        // Draw Lines to Complete Shape
        drawablePath.addLine(to: CGPoint(x: 0,
                                         y: height))
        // Draw Line to Complete Shape
        drawablePath.addLine(to: CGPoint(x: 0,
                                         y: CGFloat(height * 0.28)))
    }
    
    
    // TopLeftCornerSharpAngle
    private func drawAtTopLeftCornerSharpAngle(_ drawablePath: UIBezierPath, _ width: CGFloat, _ height: CGFloat, _ controlPoint1: inout CGPoint, _ controlPoint2: inout CGPoint) {
        // Move Pointer to the specific Location
        drawablePath.move(to: CGPoint(x: width,
                                      y: 0))
        
        // Draw Line to the point
        drawablePath.addLine(to: CGPoint(x: width,
                                         y: CGFloat(height * 0.72)))
        
        // Create 2 Control Points which are responsible for generating Curve
        controlPoint1 = CGPoint(x: CGFloat(width * 0.76),
                                y: height)
        controlPoint2 = CGPoint(x: CGFloat(width * 0.32),
                                y: CGFloat(height * 0.90))
        // Add Curve using Control Points
        drawablePath.addCurve(to:CGPoint(x: 0,
                                         y: 0 ),
                              controlPoint1: controlPoint1,
                              controlPoint2: controlPoint2)
        
        // Draw Line to Complete Shape
        drawablePath.addLine(to: CGPoint(x: width,
                                         y: 0))
    }
    
    
    // TopRightCornerSharpAngle
    private func drawAtTopRightCornerSharpAngle(_ drawablePath: UIBezierPath, _ height: CGFloat, _ controlPoint1: inout CGPoint, _ width: CGFloat, _ controlPoint2: inout CGPoint) {
        // Move Pointer to the specific Location
        drawablePath.move(to: CGPoint(x: 0,
                                      y: 0))
        
        // Draw Line to the point
        drawablePath.addLine(to: CGPoint(x: 0,
                                         y: CGFloat(height * 0.72)))
        
        // Create 2 Control Points which are responsible for generating Curve
        controlPoint1 = CGPoint(x: CGFloat(width * 0.24),
                                y: height)
        controlPoint2 = CGPoint(x: CGFloat(width * 0.68),
                                y: CGFloat(height * 0.90))
        
        // Add Curve using Control Points
        drawablePath.addCurve(to:CGPoint(x: width,
                                         y: 0 ),
                              controlPoint1: controlPoint1,
                              controlPoint2: controlPoint2)
        
        // Draw Line to Complete Shape
        drawablePath.addLine(to: CGPoint(x: 0,
                                         y: 0))
    }
    
    
    // BottomLeftCornerSharpAngle
    private func drawAtBottomLeftCornerSharpAngle(_ drawablePath: UIBezierPath, _ height: CGFloat, _ controlPoint1: inout CGPoint, _ width: CGFloat, _ controlPoint2: inout CGPoint) {
        // Move Pointer to the specific Location
        drawablePath.move(to: CGPoint(x: 0,
                                      y: height))
        
        // Create 2 Control Points which are responsible for generating Curve
        controlPoint1 = CGPoint(x: CGFloat(width * 0.32),
                                y: CGFloat(height * 0.09))
        controlPoint2 = CGPoint(x: CGFloat(width * 0.76),
                                y: CGFloat(0))
        
        // Add Curve using Control Points
        drawablePath.addCurve(to:CGPoint(x: width,
                                         y: CGFloat(height * 0.28) ),
                              controlPoint1: controlPoint1,
                              controlPoint2: controlPoint2)
        
        // Draw Lines to Complete Shape
        drawablePath.addLine(to: CGPoint(x: width,
                                         y: height))
        // Draw Line to Complete Shape
        drawablePath.addLine(to: CGPoint(x: 0,
                                         y: height))
    }
}


class ArrowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialConfig()
    }
    
    let shapeLayer = CAShapeLayer()
    
    private var fillColor: UIColor = .black
    
    /// width percentage of space between view leading and edge leading
    ///
    /// The value should be between 0 and 100
    private var leadingEdgeWidthPercentage: Int8 = 20
    
    /// width percentage of space between view trailing and edge trailing
    ///
    /// The value should be between 0 and 100
    private var trailingEdgeWidthPercentage: Int8 = 20
    
    func initialConfig() {
        self.backgroundColor = .clear
        self.layer.addSublayer(self.shapeLayer)
        self.setup()
    }
    
    func setup(fillColor: UIColor? = nil,
               leadingPercentage: Int8? = nil,
               trailingPercentage: Int8? = nil,
               animate: Bool = false) {
        
        if let fillColor = fillColor {
            self.fillColor = fillColor
        }
        
        if let leading = leadingPercentage,
           isValidPercentageRange(leading) {
            self.leadingEdgeWidthPercentage = leading
        }
        
        if let trailing = trailingPercentage,
           isValidPercentageRange(trailing) {
            self.trailingEdgeWidthPercentage = trailing
        }
        
        if animate {
            self.animateShape()
        } else {
            self.changeShape()
        }
    }
    
    private func changeShape() {
        self.shapeLayer.path = arrowShapePath().cgPath
        self.shapeLayer.fillColor = self.fillColor.cgColor
    }
    
    private func isValidPercentageRange(_ percentage: Int8) -> Bool {
        return 0 ... 100 ~= percentage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shapeLayer.removeAllAnimations()
        self.changeShape()
    }
    private func animateShape() {
        let newShapePath = arrowShapePath().cgPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2
        animation.toValue = newShapePath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.delegate = self
        
        self.shapeLayer.add(animation, forKey: "path")
    }
    
    private func arrowShapePath() -> UIBezierPath {
        let size = self.bounds.size
        let leadingEdgeWidth = size.width * CGFloat(self.leadingEdgeWidthPercentage) / 100
        let trailingEdgeWidth = size.width * (1 - CGFloat(self.trailingEdgeWidthPercentage) / 100)
        
        let path = UIBezierPath()
        
        // move to zero point (top-right corner)
        path.move(to: CGPoint(x: 0, y: 0))
        
        // move to right inner edge point
        path.addLine(to: CGPoint(x: leadingEdgeWidth, y: size.height/2))
        
        // move to bottom-left corner
        path.addLine(to: CGPoint(x: 0, y: size.height))
        
        // move to bottom-right side
        path.addLine(to: CGPoint(x: trailingEdgeWidth, y: size.height))
        
        // move to left outer edge point
        path.addLine(to: CGPoint(x: size.width, y: size.height/2))
        
        // move to top-right side
        path.addLine(to: CGPoint(x: trailingEdgeWidth, y: 0))
        
        // close the path. This will create the last line automatically.
        path.close()
        
        return path
    }
}

extension ArrowView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.changeShape()
        }
    }
}
