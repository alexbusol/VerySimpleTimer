//
//  ViewController.swift
//  VerySimpleTimer
//
//  Created by Alex Busol on 7/14/18.
//  Copyright © 2018 Alex Busol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("tickAction"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tickAction() { //gets called with every tick of the timer
        
    }


}

