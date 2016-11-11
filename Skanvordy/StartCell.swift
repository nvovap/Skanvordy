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
  
    
    var positionArrow: PositionArrow = .Right
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        drawText(rect, text: "A", context: context)
        
        if positionArrow != .None {
            drawArrow(rect, context: context)
        }
        
    }
    
    func drawText(_ rect: CGRect, text: String, context: CGContext) {
        
        //// Text Drawing
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        let textPath = UIBezierPath(rect: textRect)
        UIColor.black.setStroke()
        textPath.lineWidth = 2
        textPath.stroke()
        
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: rect.height), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = text.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        text.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
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
        bezierPath.addLine(to: CGPoint(x: 3.33, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: 0, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: 5, y: 30))
        bezierPath.addLine(to: CGPoint(x: 10, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: 6.67, y: 17.5))
        bezierPath.addLine(to: CGPoint(x: 6.67, y: 0))
        bezierPath.addLine(to: CGPoint(x: 5, y: 0))
        bezierPath.close()
      
        
        UIColor.black.setFill()
        bezierPath.fill()
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        context.restoreGState()
    }
    

}
