//
//  ManagementStudentTableViewController.swift
//  Management Student
//
//  Created by MrDummy on 5/10/17.
//  Copyright © 2017 Huy. All rights reserved.
//

import UIKit

class ManagementStudentTableViewController: UITableViewController, UISearchBarDelegate {
    
    lazy var students: [Student] = {
        return Student.createStudent()
    }()
    
    lazy var initialStudent: [Student] = {
        return Student.createStudent()
    }()

    let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:90))
    
    func searchBarDes() {
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.searchBarDes()
    }

    override func viewWillAppear(_ animated: Bool) {
        if Constants.isReload {
            let student: Student = Constants.student
            students.append(student)
            initialStudent = students
            tableView.reloadData()
            Constants.isReload = false
        }
        else{
            tableView.reloadData()
            initialStudent = students
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        if searchText.isEmpty {
            students = initialStudent
            self.tableView.reloadData()
        }else {
            filterTableView(text: searchText)
        }
    }
    
    func filterTableView(text:String) {
        tableView.reloadData()
            students = initialStudent.filter({ (stu) -> Bool in
                return stu.name.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        let student = students[indexPath.row]
        cell.lblName.text = student.name
        cell.lblUniversity.text = student.university
        cell.lblYearOld.text = student.yearold
        cell.imgStudent.image = student.image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StudentDetail") {
            let studentDetailVC = segue.destination as! StudentDetailTableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let student: Student
                student = students[indexPath.row]
                studentDetailVC.students = student
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            initialStudent = students
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentStudent = students[sourceIndexPath.row];
        students.remove(at: sourceIndexPath.row)
        students.insert(currentStudent, at: destinationIndexPath.row)
        initialStudent = students
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
