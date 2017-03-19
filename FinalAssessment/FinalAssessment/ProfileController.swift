//
//  ProfileController.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileController: UIViewController {
    
    
    
    @IBAction func signOutButton(_ sender: UIButton) {
        print("sign out button tapped")
        
        let firebaseAuth = FIRAuth.auth()!
        do {
            try! firebaseAuth.signOut()
            
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        } catch {
            print("Unknown error.")
        }
    }
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
   
    @IBOutlet weak var stepsLabel: UILabel!
    
    var user = User()
    var ref: FIRDatabaseReference!
    let userUID = SupportingFunc().currentUserUid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        fetchUserData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func fetchUserData() {
        ref.child("User").child(userUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                if let info = dictionary["info"] as? [String: String] {
                    let name = info["name"] as String? ?? ""
                    let steps = info["steps"] as String? ?? ""
                    
                    self.user = User(withUid: self.userUID, username: name, steps: steps)
                }
                DispatchQueue.main.async {
                    self.displayUserData()
                }
            }
            
        })
        
    }
    
    func displayUserData() {
        
        nameLabel.text = user.name
        stepsLabel.text = String(user.stepsTaken)

        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editProfileSegue", sender: self)
    }
    
    // MARK: - Navigation

    
    
}
