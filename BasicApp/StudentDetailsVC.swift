//
//  StudentDetailsVC.swift
//  BasicApp
//
//  Created by Randhir raj on 1/20/19.
//  Copyright © 2019 Randhir raj. All rights reserved.
//

import UIKit

class StudentDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.saveStudentDetails()
        DataManager.shared.getTableDetails(tableName: "Student")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
