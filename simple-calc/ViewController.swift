//
//  ViewController.swift
//  simple-calc
//
//  Created by Matthew Wong on 10/16/18.
//  Copyright © 2018 Matthew Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numberTouched(_ sender: UIButton, forEvent event: UIEvent) {
        let operations = ["+", "-", "*", "/", "%", "avg", "count"]
        if(!operations.contains(sender.titleLabel!.text!)) {
            display.text! += sender.titleLabel!.text!
        } else {
            display.text! += " " + sender.titleLabel!.text! + " "
        }
    }
    
    
    @IBAction func calculate(_ sender: UIButton) {
        let function = display.text!
        if(function != "") {
            let elements = function.components(separatedBy: " ")
            if(elements[1] == "avg" || elements[1] == "count") {
                let operations = ["+", "-", "*", "/", "%"]
                var total = 0.0
                var count = 0.0
                for ele in elements {
                    if(operations.contains(String(ele))) {
                        display.text! = "Invalid Operation"
                        break
                    } else {
                        if(String(ele) != "avg" && String(ele) != "count" && String(ele) != "") {
                            count = count + 1
                            total += Double(ele)!
                        }
                    }
                }
                if(display.text! != "Invalid Operation") {
                    if(elements[1] == "avg") {
                        let computed = total / count
                        display.text! = String(computed)
                    } else {
                        display.text! = String(count)
                    }
                }
            } else {
                var total = 0.0
                var operand = ""
                let operations = ["+", "-", "*", "/", "%", "avg", "count"]
                for i in 0...(elements.count - 1) {
                    if(i % 2 == 0) {
                        if(operations.contains(String(elements[i]))) {
                            display.text! = "Invalid Operation"
                            break
                        }
                        if(operand == ""){
                            total = Double(elements[i])!
                        } else {
                            total = compute(operand, total, Double(elements[i])!)
                            operand = ""
                        }
                    } else {
                        if(!operations.contains(String(elements[i])) || operand != "") {
                            display.text! = "Invalid Operation"
                            break
                        }
                        operand = String(elements[i])
                    }
                }
                if(display.text! != "Invalid Operation") {
                    display.text! = String(total)
                }
            }
        } else {
            display.text! = "Invalid Operation"
        }
    }
    
    func compute(_ operand : String, _ total: Double, _ num: Double) -> Double {
        switch operand {
        case "+":
            return total + num
        case "-":
            return total - num
        case "*":
            return total * num
        case "/":
            return total / num
        case "%":
            return Double(Int(total) % Int(num))
        default:
            return total
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text! = ""
    }
    
    @IBAction func factorial(_ sender: UIButton) {
        let function = display.text!
        let elements = function.components(separatedBy: " ")
        if(elements.count != 1) {
            var num : Double = Double(display.text!)!
            var total = 0.0
            while(num != 0) {
                total += num
                num = num - 1
            }
            display.text! = String(total)
        } else {
            display.text! = "Invalid Operation"
        }
    }
}

