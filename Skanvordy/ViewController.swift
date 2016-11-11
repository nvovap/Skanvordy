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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chengeX(_ sender: UISlider) {
        layoutWidth.constant = CGFloat(sender.value)
        layoutHeight.constant = CGFloat(sender.value)
    }

    
        
}

