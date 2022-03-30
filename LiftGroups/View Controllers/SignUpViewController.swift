//
//  SignUpViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/3/22.
//
import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //navBar.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        
        
        setUpElements()
        
        
        
        
    }
    
   
    func setUpElements() {
        
        errorLabel.alpha = 0 //hides error label
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
       // setUpNavBar()
        
    }
    
    func validateFields() -> String? {
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        //Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        //transitionToHome() // THIS IS ONLY FOR TESTING
        defaults.set(false, forKey: "stayLoggedInBool")
        //Validate fields
        let error = validateFields()
        if error != nil {
            //theres something wrong with fields, show error message
            showError(error!)
        } else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            email = email.lowercased()
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //Check for errors
                if err != nil {
                    print("THIS IS THE ERROR: \(String(describing: err))")
                    self.showError("Error creating user")
                } else {
                    //user was created successfully, now store first/last name
                    let db = Firestore.firestore()
                    
                    
                    db.collection("users").document("\(email)").setData([
                        "firstname": firstName,
                        "lastname": lastName,
                        "group": "NONE",
                        "uid": result!.user.uid
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    db.collection("users").document("\(email)").collection("personalMaxes").document("personalMaxesDoc").setData([
                        "barbellCurl": 0,
                        "benchpress": 0,
                        "deadlift": 0,
                        "legPress": 0,
                        "overheadPress": 0,
                        "pushups": 0,
                        "squat": 0,
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    
                    let userArray = [email, firstName, lastName, "NONE"]
                    self.defaults.set(email, forKey: "currentUserEmail")
                    self.defaults.set(userArray, forKey: "userArray")
                    //transition to home screen
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
    
    func sendVerificationEmail() { //is not used at the moment, does not work
        Auth.auth().currentUser?.sendEmailVerification { err in
            if err != nil {
                print("THIS IS THE ERROR: \(String(describing: err))")
                self.showError("Error sending verification email")
            }
        }
    }
    
   
    
}

