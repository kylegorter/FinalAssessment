//
//  SignUpController.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    @IBOutlet weak var registerUsername: UITextField!
    @IBOutlet weak var stepsTaken: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var registerAccountButton: UIButton! {
        didSet {
            registerAccountButton.addTarget(self, action: #selector(registerAccount(button:)), for: .touchUpInside)
        }
    }
    
    var window: UIWindow?
    
    var savedUser: User?
    
    func registerAccount(button: UIButton) {
        let username = registerUsername.text ?? ""
        let email = registerEmail.text ?? ""
        let password = registerPassword.text ?? ""
        let steps = stepsTaken.text ?? ""
        
        
        let stepsInt = Int(steps)
        
        if email == "" || password == "" {
            showAlert(withTitle: "Error", withMessage: "Please fill out all required information")
            return
        }
        
        let userDict = SupportingFunc().createStepsDict(username: username, steps: stepsInt!)
        
        //Upload username and steps into Database
        SupportingFunc().perform(actionWithType: .updateProfileInfo, targetUid: nil, dict: userDict)
        
//        if savedUser == nil {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let registerAccountError = error {
                self.showAlert(withTitle: "Error", withMessage: "\(registerAccountError)")
            }
            guard let currentUser = user else {
                return
            }
            
            self.registerAccountSucceed(email: email)
            
            
            
//            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    func handleAutoLogIn() {
        FIRAuth.auth()?.signIn(withEmail: registerEmail.text!, password: registerPassword.text!, completion: { (user, error) in
            if error != nil {
                
                let showError = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
                
                let actionError = UIAlertAction(title: "Great....", style: .default, handler: { (action) in
                    self.loadHomePage()
                })
                
                self.present(showError, animated: true, completion: nil)
                print(error! as NSError)
                return
            }
        
            
            //Call self.loadChannelPage() here for customTabBarController
        })
        
    
    }
    
    
    
    func loadHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileController") as? ProfileController
        
        //let homePage = HomeViewController()
        self.present(controller!, animated: true, completion: nil)
        
    }
    
    func registerAccountSucceed(email: String?) {
        let title = "Register Successfull"
        let message = "Register successfull for \(email)"
        
        showAlert(withTitle: title, withMessage: message)
        self.handleAutoLogIn()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
