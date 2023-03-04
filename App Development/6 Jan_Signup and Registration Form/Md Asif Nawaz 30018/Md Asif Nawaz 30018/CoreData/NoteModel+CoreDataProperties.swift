//
//  NoteModel+CoreDataProperties.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 10/1/23.
//
//

import Foundation
import CoreData


extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var note: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var email: UserModel?

}

extension NoteModel : Identifiable {

}
