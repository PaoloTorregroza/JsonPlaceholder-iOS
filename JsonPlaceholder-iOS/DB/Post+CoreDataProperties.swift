//
//  Post+CoreDataProperties.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension Post : Identifiable {

}
