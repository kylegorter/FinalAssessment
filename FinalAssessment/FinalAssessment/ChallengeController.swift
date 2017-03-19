//
//  ChallengeController.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class ChallengeController: UIViewController {
    
    var challengeUserUid = [String]()
    var users = [User]()
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        fetchChallengedUser()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func fetchChallengedUser() {
        let uid = SupportingFunc().currentUserUid()
        ref.child("Challengers").child(uid).observe(.value, with: { (snapshot) in
            self.challengeUserUid = (snapshot.value as? NSDictionary)?.allKeys as? [String] ?? []
            
            DispatchQueue.main.async {
                self.users = []
                //self.challangedUserData()
            }
        })
    }
    
    
    func fetchChallengedUserData() {
        ref.child("User").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let usersDict = snapshot.value as? [String: AnyObject] {
                
                //Originally [for userDict in usersDict {]
                for userDict in usersDict {
                    
                    let uid = userDict.key
                    
                    if self.challengeUserUid.index(of: uid) != nil {
                        
                        if let dictionary = userDict.value as? [String: AnyObject] {
                            
                            if let stepsDict = dictionary["stepsDict"] as? [String: String] {
                                let username = stepsDict["username"] as String? ?? ""
                                let steps = stepsDict["steps"] as String? ?? ""
                                let tempUser = User(withUid: uid, username: username, steps: steps)
                                
                                self.users.append(tempUser)
                            }
                            
                        }
                    }
                }
            }
        })
        
    }
    
    
    
    
    
    var selectedUser = User()
    
    
    
    
}

extension ChallengeController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "") as? ChallengeUserTableViewCell
            
            else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        
        
        
        
        cell.descriptionLabel.text = "\(user.name) \n\(user.stepsTaken)"
        
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
        
        performSegue(withIdentifier: "", sender: self)
    }
}


extension ChallengeController : ChallengeUserTableViewCellDelegate {
    func didTapUnchallenge(cell: ChallengeUserTableViewCell) {
        
        guard let index = tableView.indexPath(for: cell)
            else {
                showAlert(withTitle: "Challenge Error", withMessage: "unable to get target uid")
                return
        }
        let targetuid = users[index.row].uid
        SupportingFunc().perform(actionWithType: .unchallenge, targetUid: targetuid)
    }
    
}


