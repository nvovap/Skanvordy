//
//  ViewController.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 11/11/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WordDelegate {

  
    @IBOutlet weak var layoutHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutWidth: NSLayoutConstraint!
    

    @IBOutlet weak var word: Word!
    @IBOutlet weak var word2: Word!
    @IBOutlet weak var word3: Word!
  
    
    var selectedWord: Word?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // currentView.keyboardType = UIKeyboardType.default
        
        //currentView.nextCell = twoWord
        
        word.myGeneralLetters[1] = true
        word.myGeneralLetters[5] = true
        word.correctText = "ТРОПИНКА"
        word.delegate = self
        
        print(word)
        
        let generalLetter = GeneralLetter(word: word, indexLetter:1)
        
        
        word2.direction = .Down
        word2.generalLetters[2] = generalLetter
        word2.delegate = self
        word2.correctText = "ВОР"
        
        word3.direction = .Down
        word3.generalLetters[2] = GeneralLetter(word: word, indexLetter:5)
        word3.delegate = self
        word3.correctText = "КИНО"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chengeX(_ sender: UISlider) {
        layoutWidth.constant  = 7*25*CGFloat(sender.value)
        layoutHeight.constant = 25*CGFloat(sender.value)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("it is view touch")
    }
    
    
    func touchMe(element: Word) {
        if let selectedWord = selectedWord {
            selectedWord.deselectAndHighlight()
        }
        
        selectedWord = element
    }
    
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            word.startCell.typeArrow = .Norman
        case 1:
            word.startCell.typeArrow = .LeftRight
        case 2:
            word.startCell.typeArrow = .RightLeft
        case 3:
            word.startCell.typeArrow = .Arrow1
        default:
            word.startCell.typeArrow = .Norman
        }
    }
    
    @IBAction func changePlace(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            word.startCell.positionArrow = .Above
        case 1:
            word.startCell.positionArrow = .Below
        case 2:
            word.startCell.positionArrow = .Right
        case 3:
            word.startCell.positionArrow = .Left
        default:
            word.startCell.positionArrow = .None
        }
        
       
    }
        
}

