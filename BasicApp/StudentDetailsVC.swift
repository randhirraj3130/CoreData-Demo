//
//  StudentDetailsVC.swift
//  BasicApp
//
//  Created by Randhir raj on 1/20/19.
//  Copyright © 2019 Randhir raj. All rights reserved.
//

import UIKit
import AVFoundation

class StudentDetailsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       DataManager.shared.saveStudentDetails()
      // DataManager.shared.saveSubjeectDetails()
     // DataManager.shared.getTableDetails(tableName: "Student")
        
        
    
    }
  
}
