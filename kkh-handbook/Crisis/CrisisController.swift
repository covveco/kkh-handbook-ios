//
//  CrisisController.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CrisisController: GlobalController, UITextFieldDelegate {
	
	@IBOutlet var weightView: UIView!
	@IBOutlet var nextButton: UIButton!
	
	@IBOutlet var weightField: UITextField!
	@IBOutlet var feedback: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		weightView.roundify(10)
		weightView.drawGradientBackground(color1: .appBlue(), color2: .appBlueSecondary())
		nextButton.roundify(10)
		nextButton.backgroundColor = .black
	}
	
	// Validate weight
	// TODO Abstract weightView controls to an individual component (DRY)
	func textFieldDidEndEditing(_ textField: UITextField) {
		if weightField.isValidDecimal() {
			feedback.text = "Patient of weight \(weightField.text!.valueCheck()!)"
			feedback.textColor = .black
		} else {
			feedback.text = "Please enter valid weight"
			feedback.textColor = .red
		}
	}
	
	@IBAction func nextButtonPressed(_ sender: Any) {
		if weightField.isValidDecimal() {
			let v = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "crisisMenu") as! CrisisMenu
			v.weight = weightField.text!.valueCheck()
			self.navigationController?.pushViewController(v, animated: true)
		}
	}
}
