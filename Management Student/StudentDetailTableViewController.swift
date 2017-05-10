//
//  StudentDetailTableViewController.swift
//  Management Student
//
//  Created by MrDummy on 5/10/17.
//  Copyright © 2017 Huy. All rights reserved.
//

import UIKit

class StudentDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var tfdName: UITextField!
    @IBOutlet weak var tfdUniversity: UITextField!
    @IBOutlet weak var tfdYearOld: UITextField!
    @IBOutlet weak var imgDetailStudent: UIImageView!
    @IBOutlet weak var tvwDescription: UITextView!
    
    var students: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfdName.text = students.name
        tfdUniversity.text = students.university
        tfdYearOld.text = students.yearold
        tvwDescription.text = students.descript
        imgDetailStudent.image = students.image
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgDetailStudent.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Thư viện ảnh", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if tfdName.text!.isEmpty || tfdUniversity.text!.isEmpty ||   tfdYearOld.text!.isEmpty {
            let alert = UIAlertController(title: "Cảnh báo", message: "Vui lòng nhập đầy đủ thông tin", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
        else {
            students.name = tfdName.text!
            students.university = tfdUniversity.text!
            students.yearold = tfdYearOld.text!
            students.descript = tvwDescription.text!
            students.image = imgDetailStudent.image!
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if tfdName.isEditing {
            tfdName.resignFirstResponder()
        } else if tfdUniversity.isEditing {
            tfdUniversity.resignFirstResponder()
        }
        return true
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tfdName.resignFirstResponder()
        tfdUniversity.resignFirstResponder()
        tfdYearOld.resignFirstResponder()
        tvwDescription.resignFirstResponder()
    }
}
