//
//  StartCell.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 11/11/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

protocol StartCellDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func touchMe(element: StartCell)
    
    func gussesMe(element: StartCell)
}

class StartCell: UIView {

    
    enum PositionArrow {
        case None
        case Above
        case Below
        case Right
        case Left
    }
    
    enum TypeArrow {
        case Norman
        case LeftRight
        case RightLeft
        case Arrow1
    }
  
    weak var delegate:StartCellDelegate?
    
    var positionArrow: PositionArrow = .None {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var first: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var highlight: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var guessed: Bool = false {
        didSet {
            if let delegate = self.delegate {
                delegate.gussesMe(element: self)
            }
            setNeedsDisplay()
        }
    }
    
    var selected: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    
    var touschFirst: Bool = false
    
    var typeArrow: TypeArrow = .Norman {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var text: String = "" {
        didSet {
            if guessed {
                text = oldValue
            }
            setNeedsDisplay()
        }
        
    }
    
    
}

extension StartCell {
    
//    override var canBecomeFirstResponder: Bool {
//        get{
//            return true
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        becomeFirstResponder()
//        touschFirst = true
//        selected = true
//        setNeedsDisplay()
        
        if let delegate = self.delegate {
            delegate.touchMe(element: self)
        }
    }
    
}


//MARK: - UIKeyInput
//extension StartCell: UIKeyInput {
//    var hasText: Bool {
//        get{
//            return text.isEmpty
//        }
//    }
//    
//    func insertText(_ text: String) {
//        let upperText = text.uppercased()
//        
//        if !touschFirst {
//            resignFirstResponder()
//            selected = false
//            
//            if let nextCell = nextCell {
//                nextCell.text = upperText
//                if nextCell.nextCell != nil {
//                    resignFirstResponder()
//                    nextCell.becomeFirstResponder()
//                    nextCell.selected = true
//                }
//                
//                nextCell.setNeedsDisplay()
//            } else {
//                //Delegate for word "Ended tapping"
//            }
//        } else {
//            self.text = upperText
//            touschFirst = false
//        }
//        
//        setNeedsDisplay()
//    }
//    
//    func deleteBackward() {
//        text = ""
//        setNeedsDisplay()
//        
//        if let lastCell = lastCell {
//            resignFirstResponder()
//            lastCell.becomeFirstResponder()
//            lastCell.touschFirst = true
//        }
//    }
//    
//    
//}

//MARK: - Draw
extension StartCell {
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        drawBackground(rect, context: context)
        
        if highlight {
            drawHighlightd(rect, context: context)
        }
        
        drawText(rect, text: text, context: context)
        
        if positionArrow != .None {
            switch typeArrow {
            case .LeftRight:
                drawArrowLeftRight(rect, context: context)
            case .RightLeft:
                drawArrowRightLeft(rect, context: context)
            case .Arrow1:
                drawArrow1(rect, context: context)
            default:
                drawArrow(rect, context: context)
            }
            
        }
        
        
        
        drawBorder(rect, context: context)
        
    }
    
    
    func drawHighlightd(_ rect: CGRect, context: CGContext)  {
        
        
        
        //// Color Declarations
        var gradientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.000)
      
        gradientColor = UIColor(red: 0.660, green: 0.667, blue: 0.368, alpha: 0.200)
        
        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, UIColor.white.cgColor] as CFArray, locations: [0, 1])!
        
        let half = rect.height / 2
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect:rect)
        context.saveGState()
        rectanglePath.addClip()
        
        
        context.drawLinearGradient(gradient, start: CGPoint(x: half, y: 0), end: CGPoint(x: half, y: rect.height), options: [])
        
        context.restoreGState()
    }
    
    func drawBackground(_ rect: CGRect, context: CGContext)  {
        
        
        
        //// Color Declarations
        var gradientColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.000)
        
        if selected {
            gradientColor = UIColor(red: 0.570, green: 0.897, blue: 0.881, alpha: 1.000)
//        } else if first {
//            gradientColor =  UIColor(red: 1.000, green: 0.721, blue: 0.353, alpha: 1.000)
        }else if guessed {
            gradientColor = UIColor(red: 0.599, green: 0.881, blue: 0.570, alpha: 1.000)
        }
        
        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, UIColor.white.cgColor] as CFArray, locations: [0, 1])!
        
        let half = rect.height / 2
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect:rect)
        context.saveGState()
        rectanglePath.addClip()
       
        if selected || guessed {
            context.drawLinearGradient(gradient, start: CGPoint(x: half, y: 0), end: CGPoint(x: half, y: rect.height), options: [])
        } else {
            UIColor.white.setFill()
            rectanglePath.fill()
        }
        context.restoreGState()
    }
    
    func drawText(_ rect: CGRect, text: String, context: CGContext) {
        
        //// Text Drawing
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        //        let textPath = UIBezierPath(rect: textRect)
        //        UIColor.black.setStroke()
        //        textPath.lineWidth = 2
        //        textPath.stroke()
        
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: rect.height), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = text.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        text.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        
    }
    
    func drawBorder(_ rect: CGRect, context: CGContext) {
        
        context.saveGState()
        
        
        
        //// Bezier Drawing
        context.saveGState()
        // context.scaleBy(x: scaleX, y: scaleY)
        
        
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        let textPath = UIBezierPath(rect: textRect)
        UIColor.black.setStroke()
        
        if selected {
            textPath.lineWidth = 4
        } else {
            textPath.lineWidth = 1
        }
        
        
        textPath.stroke()
        
        context.restoreGState()
        
    }
    
    func drawArrow(_ rect: CGRect, context: CGContext) {
        
        var centerX: CGFloat = rect.width / 2
        var centerY: CGFloat = 0
        var rotat: CGFloat = 0
        
        
        if positionArrow == .Left {
            centerX = 0
            centerY = rect.height / 2
            rotat = 90
        }
        
        if positionArrow == .Below {
            centerX = rect.width / 2
            centerY = rect.height
            rotat = 180
        }
        
        if positionArrow == .Right {
            centerX = rect.width
            centerY = rect.height / 2
            rotat = 270
        }
        
        
        let scaleX: CGFloat = rect.width  / 100
        let scaleY: CGFloat = rect.height / 100
        
        
        //// Bezier Drawing
        context.saveGState()
        context.translateBy(x: centerX, y: centerY)
        context.rotate(by: -rotat * CGFloat.pi/180)
        context.scaleBy(x: scaleX, y: scaleY)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 5, y: 0))
        bezierPath.addLine(to: CGPoint(x: 3.33, y: 0))
        bezierPath.addLine(to: CGPoint(x: 3.33, y: 9))
        bezierPath.addLine(to: CGPoint(x: 0, y: 9))
        bezierPath.addLine(to: CGPoint(x: 5, y: 16))
        bezierPath.addLine(to: CGPoint(x: 10, y: 9))
        bezierPath.addLine(to: CGPoint(x: 6.67, y: 9))
        bezierPath.addLine(to: CGPoint(x: 6.67, y: 0))
        bezierPath.addLine(to: CGPoint(x: 5, y: 0))
        bezierPath.close()
        
        
        UIColor.black.setFill()
        bezierPath.fill()
        UIColor.white.setStroke()
        bezierPath.lineWidth = 0.5
        bezierPath.stroke()
        
        context.restoreGState()
        
    }
    
    func drawArrowRightLeft(_ rect: CGRect, context: CGContext) {
        
        var centerX: CGFloat = rect.width / 2
        var centerY: CGFloat = 0
        var rotat: CGFloat = 0
        
        
        if positionArrow == .Left {
            centerX = 0
            centerY = rect.height / 2
            rotat = 90
        }
        
        if positionArrow == .Below {
            centerX = rect.width / 2
            centerY = rect.height
            rotat = 180
        }
        
        if positionArrow == .Right {
            centerX = rect.width
            centerY = rect.height / 2
            rotat = 270
        }
        
        let scaleX: CGFloat = rect.width  / 100
        let scaleY: CGFloat = rect.height / 100
        
        
        context.saveGState()
        context.translateBy(x: (centerX), y: (centerY))
        context.rotate(by: -rotat * CGFloat.pi/180)
        context.scaleBy(x: scaleX, y: scaleY)
        
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 7.31, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 9, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 9, y: 11.34))
        bezier5Path.addLine(to: CGPoint(x: 3.09, y: 11.34))
        bezier5Path.addLine(to: CGPoint(x: 3.09, y: 15))
        bezier5Path.addLine(to: CGPoint(x: 0, y: 9.15))
        bezier5Path.addLine(to: CGPoint(x: 3.09, y: 3.66))
        bezier5Path.addLine(to: CGPoint(x: 3.09, y: 7.32))
        bezier5Path.addLine(to: CGPoint(x: 5.91, y: 7.32))
        bezier5Path.addLine(to: CGPoint(x: 5.91, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 7.31, y: 0))
        bezier5Path.close()
        UIColor.black.setFill()
        bezier5Path.fill()
        UIColor.white.setStroke()
        bezier5Path.lineWidth = 0.5
        bezier5Path.stroke()
        
        context.restoreGState()
        
    }
    
    func drawArrowLeftRight(_ rect: CGRect, context: CGContext) {
        
        var centerX: CGFloat = rect.width / 2
        var centerY: CGFloat = 0
        var rotat: CGFloat = 0
        
        
        if positionArrow == .Left {
            centerX = 0
            centerY = rect.height / 2
            rotat = 90
        }
        
        if positionArrow == .Below {
            centerX = rect.width / 2
            centerY = rect.height
            rotat = 180
        }
        
        if positionArrow == .Right {
            centerX = rect.width
            centerY = rect.height / 2
            rotat = 270
        }
        
        let scaleX: CGFloat = rect.width  / 100
        let scaleY: CGFloat = rect.height / 100
        
        
        context.saveGState()
        context.translateBy(x: (centerX), y: (centerY))
        context.rotate(by: -rotat * CGFloat.pi/180)
        context.scaleBy(x: scaleX, y: scaleY)
        
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 1.88, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 0, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 0, y: 11.34))
        bezier5Path.addLine(to: CGPoint(x: 6.56, y: 11.34))
        bezier5Path.addLine(to: CGPoint(x: 6.56, y: 15))
        bezier5Path.addLine(to: CGPoint(x: 10, y: 9.15))
        bezier5Path.addLine(to: CGPoint(x: 6.56, y: 3.66))
        bezier5Path.addLine(to: CGPoint(x: 6.56, y: 7.32))
        bezier5Path.addLine(to: CGPoint(x: 3.44, y: 7.32))
        bezier5Path.addLine(to: CGPoint(x: 3.44, y: 0))
        bezier5Path.addLine(to: CGPoint(x: 1.88, y: 0))
        bezier5Path.close()
        UIColor.black.setFill()
        bezier5Path.fill()
        UIColor.white.setStroke()
        bezier5Path.lineWidth = 0.5
        bezier5Path.stroke()
        
        context.restoreGState()
        
    }
    
    func drawArrow1(_ rect: CGRect, context: CGContext) {
        
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        var rotat: CGFloat = 0
        
        
        if positionArrow == .Left {
            centerX = 0
            centerY = rect.height
            rotat = 90
        }
        
        if positionArrow == .Below {
            centerX = rect.width
            centerY = rect.height
            rotat = 180
        }
        
        if positionArrow == .Right {
            centerX = rect.width
            centerY = 0
            rotat = 270
        }
        
        let scaleX: CGFloat = rect.width  / 100
        let scaleY: CGFloat = rect.height / 100
        
        
        //// Bezier 7 Drawing
        context.saveGState()
        context.translateBy(x: centerX, y: centerY)
        context.rotate(by: -rotat * CGFloat.pi/180)
        context.scaleBy(x: scaleX, y: scaleY)
        
        let bezier7Path = UIBezierPath()
        bezier7Path.move(to: CGPoint(x: 0, y: 0))
        bezier7Path.addLine(to: CGPoint(x: 22, y: 15.11))
        bezier7Path.addLine(to: CGPoint(x: 12, y: 15.11))
        bezier7Path.addLine(to: CGPoint(x: 12, y: 16))
        bezier7Path.addLine(to: CGPoint(x: 8, y: 14.67))
        bezier7Path.addLine(to: CGPoint(x: 12, y: 12.89))
        bezier7Path.addLine(to: CGPoint(x: 12, y: 13.78))
        bezier7Path.addLine(to: CGPoint(x: 18, y: 13.78))
        bezier7Path.addLine(to: CGPoint(x: 0, y: 1.78))
        bezier7Path.addLine(to: CGPoint(x: 0, y: 0))
        bezier7Path.addLine(to: CGPoint(x: 0, y: 0))
        bezier7Path.close()
        UIColor.black.setFill()
        bezier7Path.fill()
        UIColor.white.setStroke()
        bezier7Path.lineWidth = 0.5
        bezier7Path.stroke()
        
        context.restoreGState()
        
    }
}
