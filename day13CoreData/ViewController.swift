//
//  ViewController.swift
//  day13CoreData
//
//  Created by Felix-ITS016 on 12/12/19.
//  Copyright © 2019 Felix. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
 
    let delegate=UIApplication.shared.delegate as! AppDelegate
    
    func readFromCoreData()
    {
        let context = delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        //request.predicate = NSPredicate(format: "name = %@", "Nilesh")
        //request.returnsObjectsAsFaults = false
        do
        {
            let result =  try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let str = data.value(forKey: "name")as! String
                print(str)
                let contactNumber = data.value(forKey: "contactNo") as! String
                print(contactNumber)
            }
        }
        catch {
            
            print(error.localizedDescription)
        }
    }
    
    @IBOutlet weak var empNumberText: UITextField!
    
    @IBOutlet weak var empNameText: UITextField!
    
    @IBOutlet weak var empContactNoText: UITextField!
    
    @IBOutlet weak var empDepartmentNoText: UITextField!
    
    @IBOutlet weak var empSalaryText: UITextField!
    
    @IBAction func InssertButton(_ sender: UIButton)
    {
        let context=delegate.persistentContainer.viewContext;
        let empObject:NSObject = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        empObject.setValue(self.empNumberText.text, forKey: "employeeNo")
         empObject.setValue(self.empNameText.text, forKey: "name")
         empObject.setValue(self.empContactNoText.text, forKey: "contactNo")
         empObject.setValue(self.empDepartmentNoText.text, forKey: "departmentNo")
        let formater = NumberFormatter()
        let sal = formater.number(from: self.empSalaryText.text!)as! Double
        empObject.setValue(sal, forKey: "Salary")
        do
        {
            try context.save()
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Insert:Success")
    }
    
    @IBAction func UpdateButton(_ sender: UIButton) {
     
        let context = delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %", empNameText.text!)
        do
        {
            let result =  try context.fetch(request)
            print(result)
            if (result.count==1)
            {
                let object:NSManagedObject = result.first  as!NSManagedObject
                print(object)
                object.setValue(empContactNoText, forKey: "contactNo")
                try context.save()
            }
        }
            catch
            {
            print(error.localizedDescription)
                
            }
            print("Update:Success")
        }
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        
        let context=delegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
       request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", empNameText.text!)
        do
        {
            let result = try context.fetch(request)
            print(result)
            if(result.count==1)
            {
                let object:NSManagedObject = result.first as! NSManagedObject
                print(object)
                context.delete(object)
                try context.save()
            }
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Delete:Success")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         readFromCoreData()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

