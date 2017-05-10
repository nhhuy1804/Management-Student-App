//
//  CreateStudentTableViewController.swift
//  Management Student
//
//  Created by MrDummy on 5/10/17.
//  Copyright © 2017 Huy. All rights reserved.
//

import UIKit

class CreateStudentTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var tfdName: UITextField!
    @IBOutlet weak var tfdUniversity: UITextField!
    @IBOutlet weak var tfdYearOld: UITextField!
    @IBOutlet weak var imgStudent: UIImageView!
    @IBOutlet weak var tvwDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ pick: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgStudent.image = image
        pick.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ pick: UIImagePickerController) {
        pick.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if tfdName.text!.isEmpty || tfdUniversity.text!.isEmpty ||  tfdYearOld.text!.isEmpty || tvwDescription.text!.isEmpty || imgStudent.image == nil {
            let alert = UIAlertController(title: "Cảnh báo", message: "Vui lòng nhập đầy đủ thông tin", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
        else {
            Constants.isReload = true
            let student: Student = Student(nam: tfdName.text!, uni: tfdUniversity.text!, yold: tfdYearOld.text!, des: tvwDescription.text!, imaged: imgStudent.image!)
            Constants.student = student
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func changeAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let alertAction = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        alertAction.addAction(UIAlertAction(title: "Thư viện ảnh", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertAction, animated: true, completion: nil)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tfdName.resignFirstResponder()
        tfdUniversity.resignFirstResponder()
        tfdYearOld.resignFirstResponder()
        tvwDescription.resignFirstResponder()
    }
}
