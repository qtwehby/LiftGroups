//
//  LoginViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/3/22.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    let db = Firestore.firestore()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var preAuth = 0
    var checked = false
    
    var playerFirstName = "BLANK"
    var playerLastName = "BLANK"
    var playerGroup = "BLANK"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        //checkStayLoggedIn()
    }
    
    func setUpElements() {
        
        errorLabel.alpha = 0 //hides error label
        
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        //Validate text fields
        
        //create cleaned versions of email/password
        
        var email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        email = email.lowercased()
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in user
        if preAuth == 3 {
            self.defaults.set("admin@wehby.com", forKey: "currentUserEmail")
            self.defaults.set(self.checked, forKey: "stayLoggedInBool")
            transitionToHome()
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
                if err != nil {
                    print("THIS IS THE ERROR: \(String(describing: err))")
                    self.showError("Could not sign in: Incorrect Password")
                } else {
                    self.defaults.set(email, forKey: "currentUserEmail")
                    self.defaults.set(self.checked, forKey: "stayLoggedInBool")
                    
                    self.setUserArray(email: email)
                    
                    self.transitionToHome()
                
                }
            
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
        
    }
    @IBAction func tempSkipButton(_ sender: Any) {
        preAuth += 1
    }
    
    func checkStayLoggedIn() {
        if defaults.bool(forKey: "stayLoggedInBool") {
            DispatchQueue.main.asyncAfter(deadline: .now() + (5)) {
                self.transitionToHome()
            }
            
        }
    }
    
    @IBAction func rememberMeButtonTapped(_ sender: Any) {
        
        if checked == false {
            rememberMeButton.setImage(UIImage(named: "images2.png"), for: UIControl.State.normal)
            checked = true
        } else {
            rememberMeButton.setImage(UIImage(named: "images.png"), for: UIControl.State.normal)
            checked = false
        }


    }
    
    func setUserArray(email: String) {
        let docRef = db.collection("users").document(email)
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataDescription = document.get("firstname")!
                self.playerFirstName = String(describing: dataDescription)
                dataDescription = document.get("lastname")!
                self.playerLastName = String(describing: dataDescription)
                dataDescription = document.get("group")!
                self.playerGroup = String(describing: dataDescription)
                
                let userArray = [email, self.playerFirstName, self.playerLastName, self.playerGroup]
                self.defaults.set(userArray, forKey: "userArray")
            } else {
                print("Document does not exist")
            }
        }

    }
    
}
