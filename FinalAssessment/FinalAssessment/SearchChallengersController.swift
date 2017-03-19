//
//  SearchChallengersController.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/19/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit

import UIKit
import Firebase
import FirebaseDatabase

class SearchChallengersController: UIViewController {
    
    
    var users = [User]()
    var filteredUsers = [User]()
    
    var matchedUser = [String]()
    
    var tempUser = [String]()
    
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
//        fetchMatchedUser()
        fetchAllChallengers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchChallengedUser() {
        
    }


    
    func fetchAllChallengers() {
        
        ref.child("User").observeSingleEvent(of: .value, with: { (snapshot) in
            if let usersDict = snapshot.value as? [String: AnyObject] {
                
                for userDict in usersDict {
                    let uid = userDict.key
                    
                    if self.tempUser.index(of: uid) == nil {
                        if let dictionary = userDict.value as? [String: AnyObject] {
                            
                            if let challengersDict = dictionary["challengersDict"] as? [String: String] {
                                let username = challengersDict["username"] as String? ?? ""
                                let steps = challengersDict["steps"] as String? ?? ""
                                let challengeUser = User(withUid: uid, username: username, steps: steps)
                                
                                self.users.append(challengeUser)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.displayAllUserData()
                }
            }
        })
    }
    
    
    
  
    
    func displayAllUserData(){
        filteredUsers = users
        tableView.reloadData()
    }
    
    
}

extension SearchChallengersController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? SearchTableViewCell
            else { return UITableViewCell() }
        
        let user = users[indexPath.row]
       
        
        cell.descriptionLabel.text = "\(user.name) \n\(user.stepsTaken)"
        
        
        
        cell.delegate = self
        
        return cell
    }
    
}

extension SearchChallengersController : SearchTableViewCellDelegate {
    func didTapChallenge(atCell cell: SearchTableViewCell) {
        
        guard let index = tableView.indexPath(for: cell)
            else {
                
                
                showAlert(withTitle: "Challenge Error", withMessage: "unable to get target uid")
                return
        }
        let targetuid = filteredUsers[index.row].uid
        SupportingFunc().perform(actionWithType: .challenge, targetUid: targetuid)
    }
    

}
