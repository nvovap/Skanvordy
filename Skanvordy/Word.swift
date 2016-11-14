//
//  Word.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 12.11.16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

protocol WordDelegate: class {
    // The following command (ie, method) must be obeyed by any
    // underling (ie, delegate) of the older sibling.
    func touchMe(element: Word)
}

class GeneralLetter {
    weak var word: Word!
    var indexLetter: Int
    
    
    init(word: Word, indexLetter: Int) {
        self.word = word
        
        print(self.word)
        self.indexLetter = indexLetter
    }
    
}

class Word: UIView, StartCellDelegate {
    
    enum Direction {
        case Down
        case Right
    }
    
    var generalLetters = [Int: GeneralLetter]()
    
    var myGeneralLetters = [Int:Bool]()
    
     weak var delegate:WordDelegate?
    
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
    
    
    
    var startCell: StartCell!
    var correctText: String = "" {
        didSet {
            for _ in 1...correctText.characters.count {
                currentText += " "
            }
            build()
        }
    }
    
    var currentText: String = ""
    var gussed: Bool = false
    
    
    var direction: Direction = .Right
    
    var startPosition: CGPoint = CGPoint(x: 0, y:0)
    
    var cells = [StartCell]()
    
    var currentCell: StartCell?
    var currentIndex: Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = self.delegate {
            delegate.touchMe(element: self)
        }
    }
       
   
    func gussesMe(element: StartCell) {
        for currentElement in generalLetters {
            let currentGE = currentElement.value
            
            if element == currentGE.word.cells[currentGE.indexLetter] {
                let currentIndex = currentElement.key

                
                let startIndex = currentText.index(currentText.startIndex, offsetBy: currentIndex)
                let endIndex = currentText.index(startIndex, offsetBy: 1)
                let r = Range(startIndex..<endIndex)
                
                currentText.replaceSubrange(r, with: element.text)
                
                print("Current text delegate \(currentText)")
            }
        }
    }
    
    func touchMe(element: StartCell) {
        becomeFirstResponder()
        
        currentCell = element
        
        deselect()
        
        currentCell?.selected = true
        
        currentIndex = cells.index(of: element)!
        if !gussed {
            highlight(true)
        }
    }
    
    func highlight(_ value: Bool) {
        for element in  cells {
            element.highlight = value
        }
    }
    
    func deselectAndHighlight() {
        for element in  cells {
            element.highlight = false
            element.selected = false
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
        
        
    }
    
    private func build() {
        startCell = StartCell()
        startCell.translatesAutoresizingMaskIntoConstraints = false
        startCell.first = true
        startCell.delegate = self
        addSubview(startCell)
        
        var views = ["startCell": startCell!]
        cells.append(startCell)
        
        var spaceSize = bounds.height
        
        if direction == .Down {
            spaceSize = bounds.width
        }
        
        NSLayoutConstraint.activate([startCell.heightAnchor.constraint(equalToConstant: spaceSize)])
        NSLayoutConstraint.activate([startCell.widthAnchor.constraint(equalToConstant: spaceSize)])
        
        
        
        
        let countWords = correctText.characters.count
        
        
        
        for pref in 1..<countWords {
            
            
            var tempCell: StartCell
            
            if let generalLetters = generalLetters[pref]  {
               tempCell = generalLetters.word!.cells[generalLetters.indexLetter]
            } else {
              tempCell = StartCell()
            }
        
            tempCell.translatesAutoresizingMaskIntoConstraints = false
            tempCell.delegate = self
            
            cells.append(tempCell)
            
            
            
            if myGeneralLetters[pref] == nil {
                addSubview(tempCell)
                
                let nameCell = "cell\(pref)"
                views[nameCell] = tempCell
                
                
                NSLayoutConstraint.activate([tempCell.heightAnchor.constraint(equalTo: startCell.heightAnchor, multiplier: 1)])
                NSLayoutConstraint.activate([tempCell.widthAnchor.constraint(equalTo: startCell.widthAnchor, multiplier: 1)])
                
            }
            
        }
        
        var nap1 = "H"
        var nap2 = "V"
        
        if direction == .Down {
            nap1 = "V"
            nap2 = "H"
        }
        
        var layouts = [NSLayoutConstraint.constraints(withVisualFormat: "\(nap1):|[startCell]", options: [], metrics: nil, views: views),
                       NSLayoutConstraint.constraints(withVisualFormat: "\(nap2):|[startCell]|", options: [], metrics: nil, views: views)]
      
        var leftView = "startCell"

        
        var endElement = ""
        
        
        var nextSpace: CGFloat = 0
        
        for pref in 1..<countWords {
            
            let nameCell = "cell\(pref)"
            
            if pref == countWords {
                endElement = "|"
            }
            
            if myGeneralLetters[pref] != nil {
               nextSpace = spaceSize
               continue
            } else {
                layouts.append(NSLayoutConstraint.constraints(withVisualFormat: "\(nap1):[\(leftView)]-(\(nextSpace))-[\(nameCell)]\(endElement)", options: [], metrics: nil, views: views))
                layouts.append(NSLayoutConstraint.constraints(withVisualFormat: "\(nap2):|[\(nameCell)]|", options: [], metrics: nil, views: views))
                nextSpace = 0
            }
            
//            layouts.append(NSLayoutConstraint.constraints(withVisualFormat: "\(nap1):[\(leftView)]-(0)-[\(nameCell)]\(endElement)", options: [], metrics: nil, views: views))
//            layouts.append(NSLayoutConstraint.constraints(withVisualFormat: "\(nap2):|[\(nameCell)]|", options: [], metrics: nil, views: views))
            
            leftView = nameCell
            
            
        }
        
        NSLayoutConstraint.activate(layouts.flatMap{$0})
    
    
//        twoCell.addConstraint(NSLayoutConstraint(item: startCell, attribute: .height, relatedBy: .equal, toItem: twoCell, attribute: .height, multiplier: 1, constant: 0))
//        twoCell.addConstraint(NSLayoutConstraint(item: startCell, attribute: .width, relatedBy: .equal, toItem: twoCell, attribute: .width, multiplier: 1, constant: 0))
//        
//        threeCell.addConstraint(NSLayoutConstraint(item: startCell, attribute: .height, relatedBy: .equal, toItem: threeCell, attribute: .height, multiplier: 1, constant: 0))
//        threeCell.addConstraint(NSLayoutConstraint(item: startCell, attribute: .width, relatedBy: .equal, toItem: threeCell, attribute: .width, multiplier: 1, constant: 0))
//        
        
        
        
        
        
//        NSLayoutConstraint.activate([NSLayoutConstraint.constraints(withVisualFormat: "H:|[startCell]", options: [], metrics: nil, views: views),
//                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[startCell]|", options: [], metrics: nil, views: views),
//                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[twoCell]", options: [], metrics: nil, views: views),
//                                     NSLayoutConstraint.constraints(withVisualFormat: "H:[startCell]-(0)-[twoCell]", options: [], metrics: nil, views: views),
//                                     NSLayoutConstraint.constraints(withVisualFormat: "V:|[threeCell]", options: [], metrics: nil, views: views),
//                                     NSLayoutConstraint.constraints(withVisualFormat: "H:[twoCell]-(0)-[threeCell]|", options: [], metrics: nil, views: views)].flatMap{$0})
//        
        
        
        
        
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
        
        if currentText == correctText {
            gusses()
            resignFirstResponder()
            currentIndex = 0
            highlight(false)
        } else {
            if currentIndex < cells.count {
                currentCell = cells[currentIndex]
                currentCell?.selected = true
                
            } else {
                resignFirstResponder()
                currentIndex = 0
                highlight(false)
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
