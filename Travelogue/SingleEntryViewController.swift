//
//  SingleEntryViewController.swift
//  Travelogue
//
//  Created by Jasmine Tan on 5/7/20.
//  Copyright © 2020 Jasmine Tan. All rights reserved.
//

import UIKit

class SingleEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var dateFormatter = DateFormatter()
    let imagePicker = UIImagePickerController()
    var entry : Entry?
    var trip : Trip?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         imagePicker.delegate = self
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "EEEE, MMM d yyyy h:mm a"
        
        if let entry = entry{
            titleTextField.text = entry.entryName
            descriptionTextView.text = entry.text
            dateLabel.text = "Date: \(dateFormatter.string(from: ((entry.date ?? nil) ?? nil)!))"
            imageView.image = entry.image ?? nil
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagePicker.delegate = self
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if entry == nil {//new entry
            let title = titleTextField.text ?? ""
            let text = descriptionTextView.text ?? ""
            let date = Date(timeIntervalSinceNow: 0)
            let photo = imageView.image
            
            if let entry = Entry(entryName: title, text: text, date: date, image: photo){
                print("Entry exists")
                if let trip = trip {
                    print("adding entry")
                    trip.addToRawEntries(entry)
                }
//                trip?.addToRawEntries(entry)
                do{
                    try entry.managedObjectContext?.save()
                    self.navigationController?.popViewController(animated: true)
                }catch{
                    print("entry could not be saved")
                }
                print("Entry should be saved")
            }
        }else{//update
            print("updating")
            let title = titleTextField.text ?? ""
            let text = descriptionTextView.text ?? ""
            let date = Date(timeIntervalSinceNow: 0)
            let photo = imageView.image
            //print(photo)
            entry?.update(entryName: title, text: text, date: date, image: photo)
            do{
                let managedContext = entry?.managedObjectContext
                try managedContext?.save()
            }catch{
                print("The entry could not be saved")
            }
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alertController = UIAlertController(title: "No Camera", message: "The devide does not have a camera", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        } else {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func getExistingPhoto(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image view must be bad")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("setting imageview")
            imageView.image = image
        } else {
            print("not setting imageview image")
        }
        dismiss(animated: true, completion: nil)
    }
    
}
