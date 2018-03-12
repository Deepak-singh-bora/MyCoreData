//
//  SignUp+CoreDataProperties.swift
//  MyCoreData

import Foundation
import CoreData


extension SignUp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SignUp> {
        return NSFetchRequest<SignUp>(entityName: "SignUp")
    }

    @NSManaged public var userName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?

}
