//
//  LogInController.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LogInController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton! {
        didSet {
            logInButton.addTarget(self, action: #selector(logIn(button:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.addTarget(self, action: #selector(signUp(button:)), for: .touchUpInside)
        }
    }
    
    func showAlert(withTitle title: String?, withMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Great Scott!", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func logIn(button: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: {(user, error) in
            if let authError = error {
                self.showAlert(withTitle: "Error logging in", withMessage: "Email and password do not match: \(authError)")
                return}
            
            })
            
        
    }
    
    func signUp(button: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: nil)
        
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
