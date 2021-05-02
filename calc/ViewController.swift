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
	var check = true
	var checkPoint = false
	var ten = 10.0
	
	func forTrailingZero(temp: Double) -> String {
		let tempVar = String(format: "%g", temp)
		return tempVar
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		inilizator()
		buttomReset()
		buttomEqually()
		
		buttomOperation(valueOpertion: "/", valueLeft: 295, valueTop: 210)
		buttomOperation(valueOpertion: "X", valueLeft: 295, valueTop: 305)
		buttomOperation(valueOpertion: "-", valueLeft: 295, valueTop: 400)
		buttomOperation(valueOpertion: "+", valueLeft: 200, valueTop: 495)
		
		button(number: "7", valueLeft: 10, valueTop: 210)
		button(number: "8", valueLeft: 105, valueTop: 210)
		button(number: "9", valueLeft: 200, valueTop: 210)
		
		button(number: "4", valueLeft: 10, valueTop: 305)
		button(number: "5", valueLeft: 105, valueTop: 305)
		button(number: "6", valueLeft: 200, valueTop: 305)
		
		button(number: "1", valueLeft: 10, valueTop: 400)
		button(number: "2", valueLeft: 105, valueTop: 400)
		button(number: "3", valueLeft: 200, valueTop: 400)
		
		button(number: "0", valueLeft: 10, valueTop: 495)
		
		buttomPoint()
		//button(number: ".", valueLeft: 105, valueTop: 495)
	}
	
	
	
	private func inilizator() {
		label.text = "0"
		label.backgroundColor = UIColor.blue
		label.font = UIFont.systemFont(ofSize: 40)
		self.view.addSubview(label)
		
		label.snp.makeConstraints { (make) in
			make.height.equalTo(150)
			make.width.equalTo(375)
			make.top.equalTo(50)
			make.left.equalToSuperview().offset(10)
			//make.right.equalToSuperview().offset(10)
		}
	}
	
	func button(number:String, valueLeft: Int, valueTop:Int){
		
		let button = UIButton()
		//let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
		button.setTitle(number, for: .normal)
		button.backgroundColor = UIColor.orange
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		self.view.addSubview(button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(valueLeft)
			make.top.equalTo(valueTop)
		}
		
	}
	
	func buttomOperation (valueOpertion:String,valueLeft: Int, valueTop:Int){
		
		let button = UIButton()
		button.setTitle(valueOpertion, for: .normal)
		button.backgroundColor = UIColor.orange
		button.addTarget(self, action: #selector(buttonActionOperation), for: .touchUpInside)

		self.view.addSubview(button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(valueLeft)
			make.top.equalTo(valueTop)
		}
	}
	func buttomReset (){
		
		let button = UIButton()
		button.setTitle("C", for: .normal)
		button.backgroundColor = UIColor.orange
		button.addTarget(self, action: #selector(buttonReset), for: .touchUpInside)
		
		self.view.addSubview(button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(295)
			make.top.equalTo(595)
		}
	}
	@objc func buttonReset(sender: UIButton!){
		label.text = "0"
		firstNumber = 0
		secondNumber = 0
		ten = 10.0
		checkPoint = false
		
	}
	func buttomEqually (){
		
		let button = UIButton()
		button.setTitle("=", for: .normal)
		button.backgroundColor = UIColor.orange
		button.addTarget(self, action: #selector(buttonActionEqual), for: .touchUpInside)
		self.view.addSubview(button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(295)
			make.top.equalTo(495)
		}
	}
	
	func buttomPoint(){
		
		let button = UIButton()
		button.setTitle(".", for: .normal)
		button.backgroundColor = UIColor.orange
		button.addTarget(self, action: #selector(buttonActionPoint), for: .touchUpInside)

		self.view.addSubview(button)
		
		button.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(90)
			make.left.equalToSuperview().inset(105)
			make.top.equalTo(495)
		}
	}
	@objc func buttonActionPoint(sender: UIButton!) {
		
		guard let numlabel = label.text else {  return }
		if let number = Double(numlabel){
			
			if number == 0 {
				//number = 0.0
				label.text = "0."
				checkPoint = true
			} else{
				checkPoint = true
			}
	

		
	}
	}
	
	
	@objc func buttonAction(sender: UIButton!) {
		let number = sender.currentTitle!
		
		
		
		if let numberDouble = Double(number) {
			
			if  check {
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
		check = false
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
			print("er")
		}
		check = true
	}
}

