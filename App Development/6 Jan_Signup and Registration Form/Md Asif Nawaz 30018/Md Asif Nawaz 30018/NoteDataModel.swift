//
//  NoteDataModel.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 10/1/23.
//

import Foundation
import UIKit
import CoreData


class NoteDataModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createNote(note:String, userName: String) -> NoteModel{
        let aNote = NoteModel(context: context)
        
        aNote.note = note
        aNote.createdAt = Date()
        
        let fetchReq = NSFetchRequest<UserModel>(entityName: "UserModel")
        let predicate = NSPredicate(format: "email == %@", userName)
        fetchReq.predicate = predicate
        do{
            let user = try context.fetch(fetchReq).first
            user?.addToNotes(aNote)
            try context.save()
        }catch{print(error)}
        return aNote
    }
    func getNoteByUser(userName: String) -> [NoteModel]?{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "UserModel")
        let predicate = NSPredicate(format: "email == %@", userName)
        fetchReq.predicate = predicate
        do{
            let user = try context.fetch(fetchReq).first as! UserModel
            let notes = user.notes?.allObjects as! [NoteModel]
            return notes
        }catch{
            print(error)
            
        }
        return nil
    }
    
}
