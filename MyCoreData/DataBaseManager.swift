//
//  DataBaseManager.swift
//  MyCoreData
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
import UIKit
import CoreData
import Foundation

class DataBaseManager
{
    init(nameOfentity: String)
    {
        self.entityName = nameOfentity
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let entityName: String?
    
    func getRow()-> NSManagedObject
    {
        let entityRef = NSEntityDescription.insertNewObject(forEntityName: entityName!, into: context) as! SignUp
        return entityRef
    }
    
    func save(rowValue: NSManagedObject)
    {
        do{
        try context.save()
            print("Saved")
        }
        catch{
            print("Error in saving ")
        }
    }
    
    func fetchTable() -> [NSManagedObject]?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        do{
            return (try (context.fetch(request) as? [NSManagedObject]))!
        }catch{
            print("Error in fetching table")
            return nil
        }
    }
    
    func deleteAllData()
    {
        do{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        let batchDelete = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(batchDelete)
            print("Deleted")
        }
        catch {
            print("Unable to delte")
        }
    }
    
    
    func deleteDataByIndex(index: IndexPath)
     {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        request.returnsObjectsAsFaults = false
        do{
        let table = try context.fetch(request)
        var indexx = 0
        for row in table as! [NSManagedObject]
        {
            if indexx == index.row
            {
                print("Inside fname")
                context.delete(row)
            }
            indexx = indexx + 1
        }
            
         try context.save()
        }catch{
            print("found error123")
        }
    }
    
    func updateData(index : IndexPath)-> NSManagedObject?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName!)
        request.returnsObjectsAsFaults = false
        do{
            let table = try context.fetch(request)
            var indexx = 0
            for rowToUpdate in table as! [NSManagedObject]
            {
                if indexx == index.row
                {
               
                    return rowToUpdate
                }
                indexx = indexx + 1
            }
        }catch{
            print("Error in updating")
        }
        return nil
    }
}
