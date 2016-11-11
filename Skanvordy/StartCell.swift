//
//  StartCell.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 11/11/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class StartCell: UIView {

  
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        drawArrow(rect, text: "A")
        
        
    }
    
    
    
    func drawArrow(_ rect: CGRect, text: String) {
        
        
        let context = UIGraphicsGetCurrentContext()!
        
        
        
        //// Text Drawing
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: rect.height), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = text.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        text.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        
        let centerX: CGFloat = 0
        //let centerY: CGFloat = 50
        let Y: CGFloat = rect.height / 2
        
      
        
        let centerY: CGFloat = Y
        let rotat: CGFloat = 90
        let scaleX: CGFloat = rect.width  / 100
        let scaleY: CGFloat = rect.height / 100
        
        //let scaleX: CGFloat = 1
        //let scaleY: CGFloat = 1
        
       
        
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
      
        
        UIColor.gray.setFill()
        bezierPath.fill()
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        context.restoreGState()
    }
    

}
