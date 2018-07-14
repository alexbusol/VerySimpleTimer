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
    var isRunning : Bool = false //for tracking when the timer is running. maybe there's a better way?
    var labelValue : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTimer() //getting a timer value from the user when the app appears on screen
    }
    
    func setTimer() {
        //setting the timer when the app appears on screen
        
        let alert = UIAlertController(title: "Set Timer", message: "", preferredStyle: .alert)  //getting the timer value from the user via alert
        
        alert.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = "Enter a number"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            if let labelVal = Int((alert?.textFields![0].text)!) {
                self.labelValue = labelVal //adding self because inside a closure
                self.timerOutlet.text = String(labelVal)
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tickAction), userInfo: nil, repeats: true) //starting the timer after getting the timer value from the user
        isRunning = true
    }
    
    @IBAction func playPressed(_ sender: UIBarButtonItem) {
        if isRunning == false { //making sure play works only if the timer is currently running.
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tickAction), userInfo: nil, repeats: true)
            isRunning = true
        }
    }
    
    
    @IBAction func pausePressed(_ sender: UIBarButtonItem) {
        timer.invalidate() //can be used for pausing as well
        isRunning = false
    }
    
    @IBAction func setTimerPressed(_ sender: UIBarButtonItem) {
        timer.invalidate()
        isRunning = false
        setTimer() //setting a new timer value
    }
    
    
    @IBAction func secUpPressed(_ sender: UIBarButtonItem) {
        if labelValue != nil {
            labelValue = labelValue! + 10
            timerOutlet.text = String(labelValue!)
        }
    }
    
    
    @IBAction func secDownPressed(_ sender: UIBarButtonItem) {
        if labelValue != nil {
            
            labelValue = labelValue! - 10
            
            if labelValue! > 10 {
                timerOutlet.text = String(labelValue!)
            } else { //if -10 is pressed when the timer value is already <10, set the label to 0 and stop the timer.
                timerOutlet.text = "0"
                timer.invalidate()
                isRunning = false
            }
        }
    }
    
    @objc func tickAction() { //gets called with every tick of the timer
        if labelValue != nil { //make sure that the timer is set
            if labelValue! > 0 { //make sure the timer is not negative
            labelValue = labelValue! - 1
            timerOutlet.text = String(labelValue!)
            } else {
                timer.invalidate() //stopping the timer after reaching 0
                isRunning = false
            }
        }
        
    
    }

    @IBOutlet weak var timerOutlet: UILabel!
    
}

