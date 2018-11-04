//
//  ViewController.swift
//  namesToFaces
//
//  Created by Soheil on 30/10/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
	
	var people = [Person]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
	}
	
	@objc func addNewPerson() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return people.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
		guard indexPath.row < people.count else {
			return cell
		}
		let person = people[indexPath.row]
		cell.name.text = person.name
		let imagePath = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard indexPath.row < people.count else {
			return
		}
		let person = people[indexPath.row]
		
		let ac = UIAlertController(title: "Rename person", message:
			nil, preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
			let newName = ac.textFields![0]
			person.name = newName.text ?? ""
			self.collectionView?.reloadData()
		})
		present(ac, animated: true)
	}
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
			return
		}
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let imageData = UIImageJPEGRepresentation(image, 70) {
			do {
				try imageData.write(to: imagePath)
			} catch {
				print("error happened during writing photo to disk")
			}
		}
		
		let person = Person(name: "Sample", image: imageName)
		people.append(person)
		collectionView?.reloadData()
		
		dismiss(animated: true)
	}
	
	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory,
											 in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	
}

