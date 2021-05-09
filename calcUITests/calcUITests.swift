//
//  calcUITests.swift
//  calcUITests
//
//  Created by Никита on 02.05.2021.
//

import XCTest

class Practice1UITests: XCTestCase
{
	
	let app = XCUIApplication()
	
	func testSumm()
	{
		self.app.launch()
		app.buttons["identifier1"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifier+"].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier1"].tap()
		app.buttons["identifier="].tap()
		self.checkText(labelId: "answerView", text: "444")
	}
	
	func testRazn()
	{
		self.app.launch()
		app.buttons["identifier1"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifier-"].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier1"].tap()
		app.buttons["identifier="].tap()
		self.checkText(labelId: "answerView", text: "-198")
	}

	func testMnoj()
	{
		self.app.launch()
		app.buttons["identifier1"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifierX"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier="].tap()
		self.checkText(labelId: "answerView", text: "246")
	}
//	
	func testPoint()
	{
		self.app.launch()
		app.buttons["identifier0"].tap()
		//app.staticTexts["identifier."].firstMatch.tap()
	//	app.cells["identifier."].buttons["identifier."].tap()
		app.buttons["identifier."].tap()
		app.buttons["identifier3"].tap()
		app.buttons["identifier+"].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier."].tap()
		app.buttons["identifier2"].tap()
		app.buttons["identifier="].tap()
		self.checkText(labelId: "answerView", text: "2.5")
	}

}

extension Practice1UITests
{
	func checkText(labelId: String, text: String)
	{
		let label = self.app.label(identifaer: labelId)
		if label.label != text
		{
			_ = expectation(description: "Не тот текст")
		}
	}
}

extension XCUIApplication
{
	func label(identifaer: String) -> XCUIElement
	{
		self.staticTexts[identifaer]
	}
}


