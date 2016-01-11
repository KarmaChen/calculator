//
//  ViewController.swift
//  calculator
//
//  Created by 陈昆涛 on 15/12/24.
//  Copyright © 2015年 陈昆涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsTheMiddleOfTypeingNumber:Bool = false
    @IBAction func appenDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTheMiddleOfTypeingNumber{
           display.text=display.text!+digit
        }else{
            display.text=digit
            userIsTheMiddleOfTypeingNumber=true
        }
        
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTheMiddleOfTypeingNumber{
            enter()
        }
        switch operation{
//        case "☓":performOperation( {(op1:Double,op2:Double)->Double in
//            return op1*op2
//        }) 自动推断类型 所以可以去掉double
//        case "☓":performOperation( {(op1,op2) in return op1*op2})不强制给参数取名
//        case "☓":performOperation({ $0 * $1 }) 参数放在外
           case "☓":performOperation{ $0 * $1 }
           case "⌹":performOperation{ $1/$0  }
           case "+":performOperation{ $0 + $1 }
           case "-":performOperation{ $1 - $0 }
            case "✓":pperformOperation{ sqrt($0) }
        default: break
            
        }
    }
    func performOperation(operation:(Double,Double)->Double){
        if operandStack.count>=2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    func pperformOperation(operation:Double ->Double){
        if operandStack.count>=1{
            displayValue = operation(operandStack.removeLast())
                enter()
        }
    }

    func mutiply(op1:Double,op2:Double)->Double{
        return op1*op2
    }
    var operandStack:Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        userIsTheMiddleOfTypeingNumber = false
        operandStack.append(displayValue)
        print("operandStack= \(operandStack)")
        
    }
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text="\(newValue)"
            userIsTheMiddleOfTypeingNumber = false
        }
    }

}

