//
//  ViewController.swift
//  calculatror
//
//  Created by Никита on 01.05.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
	var label = UILabel()
	var firstNumber: Double = 0
	var secondNumber: Double = 0
	var operation: String = ""
	var checkFirstnumAndSecondnum = true
	var checkPoint = false
	var ten = 10.0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initButtom()
		configurationLabel()
	}
	
	// MARK:- Инициализация интрефейса
	private func  initButtom(){
		configurationButton(number: "/", valueLeft: 295, valueTop: 210)
		configurationButton(number: "X", valueLeft: 295, valueTop: 305)
		configurationButton(number: "-", valueLeft: 295, valueTop: 400)
		configurationButton(number: "+", valueLeft: 200, valueTop: 495)
		
		configurationButton(number: "=", valueLeft: 295, valueTop: 495)
		configurationButton(number: ".", valueLeft: 105, valueTop: 495)
		configurationButton(number: "C", valueLeft: 295, valueTop: 595)
		
		configurationButton(number: "0", valueLeft: 10, valueTop: 495)
		configurationButton(number: "1", valueLeft: 10, valueTop: 400)
		configurationButton(number: "2", valueLeft: 105, valueTop: 400)
		configurationButton(number: "3", valueLeft: 200, valueTop: 400)
		configurationButton(number: "4", valueLeft: 10, valueTop: 305)
		configurationButton(number: "5", valueLeft: 105, valueTop: 305)
		configurationButton(number: "6", valueLeft: 200, valueTop: 305)
		configurationButton(number: "7", valueLeft: 10, valueTop: 210)
		configurationButton(number: "8", valueLeft: 105, valueTop: 210)
		configurationButton(number: "9", valueLeft: 200, valueTop: 210)
	}
	
	private func configurationLabel() {
		label.text = "0"
		label.backgroundColor = UIColor.blue
		label.font = UIFont.systemFont(ofSize: 40)
		self.label.accessibilityIdentifier = "answerView"
		self.view.addSubview(label)
		label.snp.makeConstraints { (make) in
			make.height.equalTo(150)
			make.width.equalTo(375)
			make.top.equalTo(50)
			make.left.equalToSuperview().offset(10)
		}
	}
	
	func configurationButton(number:String, valueLeft: Int, valueTop:Int){
		let button = UIButton()
		button.setTitle(number, for: .normal)
		button.backgroundColor = UIColor.orange
		button.accessibilityIdentifier = String("identifier" + number)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		self.view.addSubview(button)
		
		buttonChoice(name: number, button: button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(valueLeft)
			make.top.equalTo(valueTop)
		}
	}
	
	func buttonChoice(name:String, button:UIButton){
		switch name {
		case "/","X","+","-":
			button.addTarget(self, action: #selector(buttonActionOperation), for: .touchUpInside)
		case "=":
			button.addTarget(self, action: #selector(buttonActionEqual), for: .touchUpInside)
		case "C":
			button.addTarget(self, action: #selector(buttonReset), for: .touchUpInside)
		case ".":
			button.addTarget(self, action: #selector(buttonActionPoint), for: .touchUpInside)
		default:
			button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		}
	}
	// MARK:- Реализация логики кнопок
	@objc func buttonReset(sender: UIButton!){
		label.text = "0"
		firstNumber = 0
		secondNumber = 0
		ten = 10.0
		checkPoint = false
	}
	
	@objc func buttonActionPoint(sender: UIButton!) {
		guard let numlabel = label.text else {  return }
		if let number = Double(numlabel){
			if number == 0 {
				label.text = "0."
				checkPoint = true
			} else{
				label.text?.insert(".", at: label.text!.endIndex)
				checkPoint = true
			}
		}
	}
	
	@objc func buttonAction(sender: UIButton!) {
		let number = sender.currentTitle!
		if let numberDouble = Double(number) {
			if  checkFirstnumAndSecondnum {
				if checkPoint {
					firstNumber += numberDouble/ten
					ten *= 10
					label.text = forTrailingZero(temp: firstNumber)
				} else {
					firstNumber = numberDouble + 10 * firstNumber
					label.text = forTrailingZero(temp: firstNumber)
				}
			} else {
				if checkPoint {
					secondNumber += numberDouble/ten
					ten *= 10
					label.text = forTrailingZero(temp: secondNumber)
				} else {
					secondNumber = numberDouble + 10 * secondNumber
					label.text =  forTrailingZero(temp: secondNumber)
				}
			}
		}
		
	}
	
	@objc func buttonActionOperation(sender: UIButton!) {
		operation = sender.currentTitle!
		label.text = operation
		checkFirstnumAndSecondnum = false
		checkPoint = false
		ten = 10.0
	}
	
	@objc func buttonActionEqual(sender: UIButton!) {
		switch operation {
		case "+":
			label.text = forTrailingZero(temp: firstNumber + secondNumber)
		case "X":
			label.text = forTrailingZero(temp: firstNumber * secondNumber)
		case "/":
			label.text = forTrailingZero(temp: firstNumber / secondNumber)
		case "-":
			label.text = forTrailingZero(temp: firstNumber - secondNumber)
		default:
			print("error")
		}
		checkFirstnumAndSecondnum = true
	}
}

// MARK:- Корректировка вывода Double
extension ViewController {
	func forTrailingZero(temp: Double) -> String {
		let tempVar = String(format: "%g", temp)
		return tempVar
	}
}
