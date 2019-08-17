//
//  DataManager.swift
//  BasicApp
//
//  Created by Randhir raj on 1/20/19.
//  Copyright © 2019 Randhir raj. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    static let shared = DataManager()
    
    func retunContext()->NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveStudentDetails(){
        
        //St
//        let  studentData12 = Student(context: self.retunContext())
//        studentData12.name = "raju"
//        studentData12.roll_number = 0070
//        studentData12.school_name = "gnit"
//        studentData12.student_id = 1
//        studentData12.student_class = "9"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    // MARK: - Core Data Saving support
    func saveSubjeectDetails(){

        let context = self.retunContext()
//        let subjectContaxt = Subject(context: context)
//        subjectContaxt.hindi = "10"
//        subjectContaxt.english = "20"
//        subjectContaxt.maths = "30"
//        subjectContaxt.science = "40"
//        subjectContaxt.social_science = "50"
//        subjectContaxt.student_id = 3
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
     /// get table data in dictionary form
    func getTableDetails(tableName:String){
        
        var dataArrray = [Any]()
        //let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        do {
            let result = try self.retunContext().fetch(request)
            
            for data in result as! [NSManagedObject] {
                let keys = Array(data.entity.attributesByName.keys)
                let dict = data.dictionaryWithValues(forKeys: keys)
                
                let john: Student = data as! Student
               // let johnSubject = john.studentSubjectRelation?.hindi
                //print("johnSubject--->>",johnSubject)
                
                dataArrray.append(dict)
            }
            
           /// result.last
           //let john: Student = result.first as! Student
           //let johnSubject = john.studentSubjectRelation?.hindi
            //print("johnSubject--->>",johnSubject)
            //print("dataArrray--->>>",dataArrray)
        } catch {
            print("Failed")
        }
    }
}
