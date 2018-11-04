//
//  Person.swift
//  namesToFaces
//
//  Created by Soheil on 04/11/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class Person: NSObject {
	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
}
