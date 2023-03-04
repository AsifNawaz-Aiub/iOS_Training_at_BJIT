//
//  UserModel+CoreDataProperties.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 10/1/23.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var email: String?
    @NSManaged public var fullName: String?
    @NSManaged public var password: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension UserModel {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: NoteModel)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: NoteModel)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension UserModel : Identifiable {

}
