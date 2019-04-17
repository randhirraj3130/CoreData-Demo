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
        if #available(iOS 10.0, *) {
            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
           return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        }
    }
    // MARK: - Core Data Saving support
    func saveStudentDetails(){

        
       // var studentData:Student = Student()
        if #available(iOS 10.0, *) {
            let  studentData = Student(context: self.retunContext())
        } else {
            // Fallback on earlier versions
            let entity = NSEntityDescription.entity(forEntityName: "Student", in: self.retunContext())!
            
           let studentData12 = Student(entity: entity, insertInto: self.retunContext())
            studentData12.name = "randhir"
            studentData12.roll_number = 0075
            studentData12.school_name = "GNIOT"
            studentData12.student_id = 1
            studentData12.subject = 60.0
            studentData12.student_class = "9"
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
        

//        // save data in local Db
//        do {
//            print("saveStudentDetails save success")
//            try self.retunContext().save()
//        } catch {
//            print("Failed saving")
//        }
    }
    // MARK: - Core Data Saving support
    func saveSubjeectDetails(){

//        let context = self.persistentContainer.viewContext
//        let subjectContaxt = Subject(context: context)
//
//        subjectContaxt.hindi = "70"
//        subjectContaxt.english = "70"
//        subjectContaxt.maths = "70"
//        subjectContaxt.science = "70"
//        subjectContaxt.social_science = "70"

       // let studentData = Student(context: context)


//        studentData.name = "randhir"
//        studentData.roll_number = 0075
//        studentData.school_name = "GNIOT"
//        studentData.student_id = 1
//        studentData.subject = 60.0

        // save data in local Db
//        do {
//            print("saveStudentDetails save success")
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
    }
     // get table data in dictionary form
    func getTableDetails(tableName:String){
        
        
        var dataArrray = [Any]()
        //let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        do {
            let result = try self.retunContext().fetch(request)
            for data in result as! [NSManagedObject] {
                let keys = Array(data.entity.attributesByName.keys)
                let dict = data.dictionaryWithValues(forKeys: keys)
                dataArrray.append(dict)
            }
            print("dataArrray--->>>",dataArrray)
        } catch {
            print("Failed")
        }
    }



}
