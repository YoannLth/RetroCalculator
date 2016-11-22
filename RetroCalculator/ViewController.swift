//
//  ViewController.swift
//  RetroCalculator
//
//  Created by yoann lathuiliere on 22/11/2016.
//  Copyright © 2016 ylth. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var divideButton: UIButton!
  @IBOutlet weak var multiplyButton: UIButton!
  @IBOutlet weak var substractButton: UIButton!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var equalButton: UIButton!
  
  var btnSound: AVAudioPlayer!
  var runningNumber = ""
  var currentOperation = Operation.Empty
  var leftHand = ""
  var rightHand = ""
  var result = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
    
    do{
      try btnSound = AVAudioPlayer(contentsOf: soundURL)
    } catch let err as NSError{
      print(err.debugDescription)
    }
  }

  @IBAction func numberPressed(sender: UIButton){
    playSound()
    
    runningNumber += "\(sender.tag)"
    outputLabel.text = runningNumber
  }
  
  @IBAction func divideButtonPressed(sender: AnyObject){
    processOperation(operation: Operation.Divide)
    divideButton.backgroundColor = .clear
    divideButton.layer.cornerRadius = 5
    divideButton.layer.borderWidth = 5
    divideButton.layer.borderColor = UIColor.red.cgColor
    
    multiplyButton.layer.borderWidth = 0.0;
    substractButton.layer.borderWidth = 0.0;
    addButton.layer.borderWidth = 0.0;
    equalButton.layer.borderWidth = 0.0;
  }
  
  @IBAction func multiplyButtonPressed(sender: AnyObject){
    processOperation(operation: Operation.Multiply)
    multiplyButton.backgroundColor = .clear
    multiplyButton.layer.cornerRadius = 5
    multiplyButton.layer.borderWidth = 5
    multiplyButton.layer.borderColor = UIColor.red.cgColor
    
    divideButton.layer.borderWidth = 0.0;
    substractButton.layer.borderWidth = 0.0;
    addButton.layer.borderWidth = 0.0;
    equalButton.layer.borderWidth = 0.0;
  }
  
  @IBAction func substractButtonPressed(sender: AnyObject){
    processOperation(operation: Operation.Substract)
    substractButton.backgroundColor = .clear
    substractButton.layer.cornerRadius = 5
    substractButton.layer.borderWidth = 5
    substractButton.layer.borderColor = UIColor.red.cgColor
    
    multiplyButton.layer.borderWidth = 0.0;
    divideButton.layer.borderWidth = 0.0;
    addButton.layer.borderWidth = 0.0;
    equalButton.layer.borderWidth = 0.0;
  }
  
  @IBAction func addButtonPressed(sender: AnyObject){
    processOperation(operation: Operation.Add)
    addButton.backgroundColor = .clear
    addButton.layer.cornerRadius = 5
    addButton.layer.borderWidth = 5
    addButton.layer.borderColor = UIColor.red.cgColor
    
    multiplyButton.layer.borderWidth = 0.0;
    substractButton.layer.borderWidth = 0.0;
    divideButton.layer.borderWidth = 0.0;
    equalButton.layer.borderWidth = 0.0;
  }
  
  @IBAction func equalButtonPressed(sender: AnyObject){
    processOperation(operation: currentOperation)
    equalButton.backgroundColor = .clear
    equalButton.layer.cornerRadius = 5
    equalButton.layer.borderWidth = 5
    equalButton.layer.borderColor = UIColor.red.cgColor
    
    multiplyButton.layer.borderWidth = 0.0;
    substractButton.layer.borderWidth = 0.0;
    addButton.layer.borderWidth = 0.0;
    divideButton.layer.borderWidth = 0.0;
  }
  
  @IBAction func clearButtonPressed(_ sender: Any) {
    runningNumber = ""
    currentOperation = Operation.Empty
    leftHand = ""
    rightHand = ""
    result = ""
    outputLabel.text = ""
    
    multiplyButton.layer.borderWidth = 0.0;
    substractButton.layer.borderWidth = 0.0;
    addButton.layer.borderWidth = 0.0;
    divideButton.layer.borderWidth = 0.0;
    equalButton.layer.borderWidth = 0.0;
  }
  
  func playSound(){
    if btnSound.isPlaying{
      btnSound.stop()
    }
    btnSound.play()
  }
  
  func processOperation(operation: Operation){
    playSound()
    if currentOperation != Operation.Empty{
      if runningNumber != ""{
        rightHand = runningNumber
        runningNumber = ""
        
        if currentOperation == Operation.Multiply{
          result = "\(Double(leftHand)! * Double(rightHand)!)"
        }else if currentOperation == Operation.Divide{
          result = "\(Double(leftHand)! / Double(rightHand)!)"
        }else if currentOperation == Operation.Substract{
          result = "\(Double(leftHand)! - Double(rightHand)!)"
        }else if currentOperation == Operation.Add{
          result = "\(Double(leftHand)! +  Double(rightHand)!)"
        }
        
        leftHand = result
        outputLabel.text = result
      }
      
      currentOperation = operation
    } else{
      leftHand = runningNumber
      runningNumber = ""
      currentOperation = operation
    }
  }
}

