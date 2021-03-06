//
//  Cell.swift
//  kkh-handbook
//
//  Created by Sean Lim on 18/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

// Table view
extension ReferenceView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView,
				   didSelectRowAt indexPath: IndexPath) {
		let fileView = content[indexPath.section].1[indexPath.row]
													.buildController()
		self.navigationController?.pushViewController(fileView, animated: true)
		self.navigationController?.navigationBar.prefersLargeTitles = false
	}
	
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		return content[section].1.count
	}
	
	func tableView(_ tableView: UITableView,
				   viewForHeaderInSection section: Int) -> UIView? {
		let headerView = ReferenceSectionHeader.instanceFromNib()
		headerView.label?.text = content[section].0
		return headerView
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return content.count
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView
			.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
		
		// Set name
		let file = content[indexPath.section].1[indexPath.row]
		cell.label.text = file.name
		
		// Set styles
		cell.indicator.alpha = 0
		if file.isBookmarked {
			cell.indicator.alpha = 1
			cell.label.textColor = .darkText
		}
	
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let file = content[indexPath.section].1[indexPath.row]
		
		let action = UIContextualAction(style: .normal, title: nil) {
			_, _, _ in
			UserDefaults.standard.set(!file.isBookmarked, forKey: String(file.id))
			tableView.setEditing(false, animated: true)
			tableView.reloadRows(at: [indexPath], with: .right)
		}
		
		action.image = file.isBookmarked ? #imageLiteral(resourceName: "cancel"):#imageLiteral(resourceName: "bookmark") // RIP light theme users
		action.backgroundColor = file.isBookmarked ? .red:.bookmarkOrange()
		
		let swipeConfig = UISwipeActionsConfiguration(actions:[action])
		
		return swipeConfig
	}
	
}

class ReferenceSectionHeader: UIView {
	@IBOutlet var label: UILabel!
	class func instanceFromNib() -> ReferenceSectionHeader {
		return UINib(nibName: "Section header", bundle: nil)
			.instantiate(withOwner: nil,
						 options: nil)[0] as! ReferenceSectionHeader
	}
}
