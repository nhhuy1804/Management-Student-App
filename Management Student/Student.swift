//
//  Student.swift
//  Management Student
//
//  Created by MrDummy on 5/10/17.
//  Copyright © 2017 Huy. All rights reserved.
//

import Foundation
import UIKit

class Student: NSObject {
    var name: String
    var university: String
    var descript: String
    var yearold: String
    var image: UIImage
    
    init(nam: String, uni: String, yold: String, des: String, imaged: UIImage) {
        self.name = nam
        self.university = uni
        self.descript = des
        self.yearold = yold
        self.image = imaged
    }
    
    class func createStudent() -> [Student]{
        var students = [Student]()
        students.append(Student(nam: "Ronaldo", uni: "Madrid", yold: "30", des: "Best player", imaged: #imageLiteral(resourceName: "h1")))
        students.append(Student(nam: "Donald Trumb", uni: "Havard", yold: "50", des: "President", imaged: #imageLiteral(resourceName: "h2")))
        students.append(Student(nam: "Logan", uni: "Empty", yold: "45", des: "X men", imaged: #imageLiteral(resourceName: "h3")))
        students.append(Student(nam: "Clark Kent", uni: "USA", yold: "30", des: "Superman", imaged: #imageLiteral(resourceName: "h4")))
        
        return students
    }
}
