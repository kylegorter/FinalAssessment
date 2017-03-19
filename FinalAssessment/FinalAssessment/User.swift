//
//  User.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FBSDKShareKit
import FBSDKCoreKit

import Foundation

class User {
    
    var uid : String
    var name : String
    var stepsTaken : Int

    var description : String?

    
    init() {
        name = "name"
        stepsTaken = 150

        uid = "123"
    }
    

    
    init(withUid userId: String, username: String, steps: String) {
        uid = userId
        name = username
        stepsTaken = Int(steps) ?? 0

        

        
    }
}
