//
//  ViewController.swift
//  Skanvordy
//
//  Created by Vladimir Nevinniy on 11/11/16.
//  Copyright © 2016 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layoutHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutWidth: NSLayoutConstraint!
    
    @IBOutlet weak var currentView: StartCell!
    @IBOutlet weak var twoWord: StartCell!
    @IBOutlet weak var text: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // currentView.keyboardType = UIKeyboardType.default
        
        //currentView.nextCell = twoWord
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chengeX(_ sender: UISlider) {
        layoutWidth.constant = CGFloat(sender.value)
        layoutHeight.constant = CGFloat(sender.value)
    }

    @IBAction func editChange(_ sender: Any) {
        currentView.text = text.text!
    }
 
    
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentView.typeArrow = .Norman
        case 1:
            currentView.typeArrow = .LeftRight
        case 2:
            currentView.typeArrow = .RightLeft
        case 3:
            currentView.typeArrow = .Arrow1
        default:
            currentView.typeArrow = .Norman
        }
    }
    
    @IBAction func changePlace(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentView.positionArrow = .Above
        case 1:
            currentView.positionArrow = .Below
        case 2:
            currentView.positionArrow = .Right
        case 3:
            currentView.positionArrow = .Left
        default:
            currentView.positionArrow = .None
        }
        
       
    }
        
}

