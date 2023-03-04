//
//  UserDataModel.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 9/1/23.
//

import Foundation
import UIKit
import CoreData

class UserDataModel{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createUser(formData: Form) -> UserModel{
        let newUser =  UserModel(context: context)
        newUser.fullName = formData.fullNameTextField
        newUser.email = formData.emailTextField
        newUser.password = formData.passwordTextField
        newUser.createdAt =  Date()
        newUser.updatedAt = Date()
        
        do{
            try context.save()
            
        }catch{
            print(error)
            
        }
        return newUser
       
    }
    
    func getAllUsers() -> [UserModel]{
        var users: [UserModel] = []
        do{
            users = try context.fetch(UserModel.fetchRequest())
            //print(users[0].fullName, users[1].fullName )
        }
        catch{
            print(error)
        }
        return users
    }
    
    func deleteUser(userToDelete: UserModel) -> Bool{
         
        context.delete(userToDelete)
        
        do{
            try context.save()
        }catch{
            print(error)
            return false
        }
        return true
        
    }
    func updateRecord(index: Int,editedName:String, users: inout [UserModel]) -> Bool {
        let user = users[index]
        user.fullName =  editedName
        do {
            try context.save()
            return true
        } catch {
            print(error)
            return false
        }

    }
    
    func authenticateUser(username: String, password:String) -> [UserModel]?{
        let fetchReq = NSFetchRequest<UserModel>(entityName: "UserModel")
        let predicate =  NSPredicate(format: "email == %@ AND password == %@", username,password)
        fetchReq.predicate = predicate
        do{
            let result = try context.fetch(fetchReq)
            return result
        }catch{
            print(error)
            return nil
        }
    }
}
