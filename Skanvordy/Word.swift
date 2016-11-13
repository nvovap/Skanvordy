//
//  Word.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 12.11.16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class Word: UIView, StartCellDelegate {
    
    enum Direction {
        case Down
        case Right
    }
    
    var startCell: StartCell!
    
    var correctText: String = "WAY"
        //{
//        didSet {
//            let length = correctText.lengthOfBytes(using: String.Encoding.utf8)
//            
//            var nextCell = startCell
//            
//            for _ in 2...length {
//                nextCell.nextCell = StartCell()
//                nextCell = nextCell.nextCell!
//            }
//        }
 //   }
    
    
    var currentText: String = "   "
    var gussed: Bool = false
    
    
    var direction: Direction = .Right
    
    var startPosition: CGPoint = CGPoint(x: 0, y:0)
    
    var cells = [StartCell]()
    
    var currentCell: StartCell?
    var currentIndex: Int = 0
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
       // build()
    }
    
    func touchMe(element: StartCell) {
        becomeFirstResponder()
        
        currentCell = element
        
        deselect()
        
        currentCell?.selected = true
        
        currentIndex = cells.index(of: element)!
        
        highlight(true)
        
        
    }
    
    func highlight(_ value: Bool) {
        for element in  cells {
            element.highlight = value
        }
    }
    
    func gusses() {
        gussed = true
        for element in  cells {
            element.guessed = true
        }
    }
    
    func deselect() {
        for element in  cells {
            element.selected = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
         build()
    }
    
    private func build() {
        
       // let length = correctText.lengthOfBytes(using: String.Encoding.utf8)
        
        startCell = StartCell()
        startCell.translatesAutoresizingMaskIntoConstraints = false
        startCell.first = true
        //startCell.backgroundColor = UIColor.blue
        startCell.delegate = self
        
        addSubview(startCell)
        
        cells.append(startCell)
        
        let twoCell = StartCell()
        twoCell.translatesAutoresizingMaskIntoConstraints = false
       // twoCell.backgroundColor = UIColor.white
//        startCell.nextCell = twoCell
//        twoCell.lastCell = startCell
        twoCell.delegate = self
        addSubview(twoCell)
        
        cells.append(twoCell)
        
        let threeCell = StartCell()
        threeCell.translatesAutoresizingMaskIntoConstraints = false
       // threeCell.backgroundColor = UIColor.white
//        twoCell.nextCell = threeCell
//        threeCell.lastCell = twoCell
        threeCell.delegate = self
        addSubview(threeCell)
        
        cells.append(threeCell)
        
        
        print(bounds.height)
        
        NSLayoutConstraint.activate([startCell.heightAnchor.constraint(equalToConstant: bounds.height)])
        NSLayoutConstraint.activate([startCell.widthAnchor.constraint(equalToConstant: bounds.height)])
        
        
        NSLayoutConstraint.activate([twoCell.heightAnchor.constraint(equalToConstant: bounds.height)])
        NSLayoutConstraint.activate([twoCell.widthAnchor.constraint(equalToConstant: bounds.height)])
        
        NSLayoutConstraint.activate([threeCell.heightAnchor.constraint(equalToConstant: bounds.height)])
        NSLayoutConstraint.activate([threeCell.widthAnchor.constraint(equalToConstant: bounds.height)])
        
        let views = ["startCell": startCell, "twoCell": twoCell, "threeCell": threeCell]
        
        
        NSLayoutConstraint.activate([NSLayoutConstraint.constraints(withVisualFormat: "H:|[startCell]", options: [], metrics: nil, views: views),
                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[startCell]", options: [], metrics: nil, views: views),
                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[twoCell]", options: [], metrics: nil, views: views),
                                     NSLayoutConstraint.constraints(withVisualFormat: "H:[startCell]-(0)-[twoCell]", options: [], metrics: nil, views: views),
                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[threeCell]", options: [], metrics: nil, views: views),
                                     NSLayoutConstraint.constraints(withVisualFormat: "H:[twoCell]-(0)-[threeCell]|", options: [], metrics: nil, views: views)].flatMap{$0})
        
        
        
        
        
//        let lbl = UILabel()
//        lbl.setTranslatesAutoresizingMaskIntoConstraints(false)
//        lbl.numberOfLines = 0
//        addSubview(lbl)
//        lbl.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
//        
//        // Constrain!
//        let views = ["lbl": lbl]
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[lbl]-|", options: nil, metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[lbl]-|", options: nil, metrics: nil, views: views))
//        label = lbl
    }

}


//MARK: - UIKeyInput
extension Word: UIKeyInput {
    override var canBecomeFirstResponder: Bool {
        get{
            return true
        }
    }
    
    
    var hasText: Bool {
        get{
            return currentText.isEmpty
        }
    }
    
    func insertText(_ text: String) {
        let upperText = text.uppercased()

       
        if !currentCell!.guessed {
            currentCell?.text = upperText
        }
        
        let startIndex = currentText.index(currentText.startIndex, offsetBy: currentIndex)
        let endIndex = currentText.index(startIndex, offsetBy: 1)
        let r = Range(startIndex..<endIndex)
        
        currentText.replaceSubrange(r, with: currentCell!.text)
        
        
        print(currentText)
        
        currentCell?.selected = false
        
        currentIndex += 1
        
        if currentIndex < cells.count {
            currentCell = cells[currentIndex]
            currentCell?.selected = true
            
        } else {
            resignFirstResponder()
            currentIndex = 0
            highlight(false)
            
            if currentText == correctText {
                gusses()
            }
            
        }
    }
    
    func deleteBackward() {
        if gussed {
            resignFirstResponder()
            currentIndex = 0
            highlight(false)
        }
        
        let startIndex = currentText.index(currentText.startIndex, offsetBy: currentIndex)
        let endIndex = currentText.index(startIndex, offsetBy: 1)
        let r = Range(startIndex..<endIndex)
        
        currentText.replaceSubrange(r, with: " ")
        
        currentCell?.text = ""
        currentCell?.selected = false
        
        
        currentIndex -= 1
        
        if currentIndex >= 0 {
            currentCell = cells[currentIndex]
            currentCell?.selected = true
        } else {
            resignFirstResponder()
            currentIndex = 0
            highlight(false)
        }
        
    }

    
}
