//
//  Supporting Functions.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/18/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class SupportingFunc {
    
    var frDBref: FIRDatabaseReference!
    init(){
        frDBref = FIRDatabase.database().reference()
    }
    
    func currentUserUid() -> String {
        guard let user = FIRAuth.auth()?.currentUser
            else{
                return ""
        }
        return user.uid
    }
    
    
    func modifyDatabase(path: String,dictionary : [String : String] , autoId : Bool = false){
        if autoId{
//        childByAutoId generates a new child location using a unique key and returns a
//        FIRDatabaseReference to it. This is useful when the children of a Firebase Database location represent a list of items.
            frDBref.child("\(path)/").childByAutoId().setValue(dictionary)
        }
        else{
            frDBref.child("\(path)/").setValue(dictionary)
        }
    }
    
    
    //Modify From DataBase
    func modifyDatabase(path: String,key: String,value: String){
        frDBref.child("\(path)/\(key)").setValue(value)
    }
    
    
    // Delete From Database
    func deleteFromDatabase(path: String, item : String){
        frDBref.child("\(path)/").child(item).removeValue()
    }
    
    
   
    func createStepsDict(username: String, steps: Int) -> [String: String] {
        var dict = [String: String]()
        dict["steps"] = String(steps)
        dict["username"] = username
        
        return dict
    }
    
    
    enum actionType {

        case challenge

        case unchallenge
        
        case updateProfileInfo
    }
    
    
    func perform(actionWithType type : actionType, targetUid : String?, dict : [String : String] = [:]) {
        
        let userUid = self.currentUserUid()
        var path = ""
        
        switch type {
        case .challenge:
            guard let target = targetUid
                else {
                    break
            }
            path = "Match/\(userUid)/"
            self.modifyDatabase(path: path, key: target, value: "true")
            break
            
        case .unchallenge:
            guard let target = targetUid
                else {
                    break
            }
            path = "Match/\(userUid)/"
            self.deleteFromDatabase(path: path, item: target)
            break
            
            
        case .updateProfileInfo:
            path = "User/\(userUid)/info/"
            self.modifyDatabase(path: path, dictionary: dict)
            break
        }
    }
    
}




