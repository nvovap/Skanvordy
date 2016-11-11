//
//  StartCell.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 11/11/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

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
  
    
    var positionArrow: PositionArrow = .Above {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var typeArrow: TypeArrow = .Norman {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var text: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
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
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        let textPath = UIBezierPath(rect: textRect)
        UIColor.black.setStroke()
        textPath.lineWidth = 4
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
