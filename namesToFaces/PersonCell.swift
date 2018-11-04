//
//  PersonCell.swift
//  namesToFaces
//
//  Created by Soheil on 30/10/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var name: UILabel!
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		self.imageView.layer.borderWidth = 2
		self.imageView.layer.cornerRadius = 3
		self.layer.cornerRadius = 7
	}
	
}
