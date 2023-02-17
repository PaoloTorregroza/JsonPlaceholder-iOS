//
//  User+CoreDataProperties.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
