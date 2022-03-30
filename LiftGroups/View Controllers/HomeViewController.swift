//
//  HomeViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/3/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    
    //Array with email, FN, LN, Group
    var userArray = [String]()
    
    //these should maybe be local to the function they are in
    var barbellCurl = 1
    var benchpress = 1
    var deadlift = 1
    var legPress = 1
    var overheadPress = 1
    var pushups = 1
    var squat = 1
    var exerciseNames = ["barbellCurl", "benchpress", "deadlift", "legPress", "overheadPress", "pushups", "squat"] //used when creating a group
    
    var playerFirstName = "blankFirst" //used when importing FN
    var playerLastName = "blankLast" //used when importing LN
    var playerGroup = "NONE" //used when importing Group
    
    var MasterData = [Any]() //Houses all imported data, personal and group
    var MasterPersonalInfo = [Any]() //all personal info for user
    var MasterGroup = [Any]() //all group data for user's current group
    
    var MasterEmailsForMaxes = [String]() //list of emails in order for arrays in maxes
    var MasterEmailsForWorkouts = [String]() //list of emails in order for arrays in workouts
    var MasterMaxes = [Any]() //has email array and array for each user with maxes
    var MasterLeaderboard = [Any]() //has exercise array and maxes for each exercise
    var MasterWorkouts = [Any]() //list with all workout data, not formatted at all at the moment
    var MasterPersonalMaxes = [Any]() //list of integers for all 7 maxes saved in personal info
    var MasterExercises = [Any]()  //list of exercise names in order (alphabetical i believe), could be used for display purposes
    
    //these are not used at the moment, i dont think i will ever need them, they are only here in case something changes when i fix the leaderboard data recording system
    /*var subLeaderboardBarbellCurl = [Any]()
    var subLeaderboardBenchpress = [Any]()
    var subLeaderboardDeadlift = [Any]()
    var subLeaderboardLegPress = [Any]()
    var subLeaderboardOverheadPress = [Any]()
    var subLeaderboardPushups = [Any]()
    var subLeaderboardSquat = [Any]()*/
    
    //variables used when importing group workout max data for each member, these variables should not be global -- need to move to function
    var subMaxesBarbellCurl = 0
    var subMaxesBenchpress = 0
    var subMaxesDeadlift = 0
    var subMaxesLegPress = 0
    var subMaxesOverheadPress = 0
    var subMaxesPushups = 0
    var subMaxesSquat = 0
    var subMaxesFirstname = ""
    
    // variables used when importing personal max data
    var subPersonalMaxesBarbellCurl = 0
    var subPersonalMaxesBenchpress = 0
    var subPersonalMaxesDeadlift = 0
    var subPersonalMaxesLegPress = 0
    var subPersonalMaxesOverheadPress = 0
    var subPersonalMaxesPushups = 0
    var subPersonalMaxesSquat = 0
    
    //Arrays filled with the data for maxes and then broken down from key value pairs
    var subMaxesUserMaxes = [String : Any]()
    var personalMaxes = [String : Any]()
    
    var importDelay = 1.0 //Seems to work fine at 0.5, does not work at 0.1
    //Need to come up with someway to avoid the delay function I am using right now, maybe some sort of notification when a variable gets changed?
    
    var completionStatus = false
    var attempts = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkConnection()
        runCheckConnection()

        userArray = defaults.stringArray(forKey: "userArray") ?? ["ERR: CouldNotGetArray", "", "", ""]
        checkStayLoggedIn()
        
        //imports all data, delay must be greater than 1 as of right now to ensure that the userArray is correct in checkStayLoggedIn --- Can be shortened later
        DispatchQueue.main.asyncAfter(deadline: .now() + (importDelay + 0.1)) {
            self.importDataMaster()
        }
        
        //not necessay because of the import all data function I THINK
        getUserMaxes()
        
    }
    
    func runCheckConnection() {
        attempts += 1
        runCheckConnection2()
    }
    
    func runCheckConnection2() {
        DispatchQueue.main.asyncAfter(deadline: .now() + (0.001)) {
            if self.completionStatus == false {
                self.runCheckConnection()
            } else {
                print("Connected in \(self.attempts)ms")
            }
        }
    }
    
    func checkConnection() {
        let docRef = db.collection("Completion").document("CompletionDoc")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.get("CompletionBool")!
                self.completionStatus = dataDescription as? Bool ?? false
                print(self.completionStatus)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func newGroupTapped(_ sender: Any) {
        print("NEW group tapped")
        createGroup(groupName: "testGroup")
    }
    
    //checks to see if the user was auto logged in, if so it sets the data for the user including filling out the userArray
    func checkStayLoggedIn() {
        let userEmail = defaults.string(forKey: "currentUserEmail")
        if defaults.bool(forKey: "stayLoggedInBool") {
            getPlayerName()
            DispatchQueue.main.asyncAfter(deadline: .now() + (importDelay)) {
                self.userArray = [userEmail ?? "BLANK", self.playerFirstName, self.playerLastName, self.playerGroup]
                self.defaults.set(self.userArray, forKey: "userArray")
            }
            
            
        }
    }
    
    //temporary function used to create a group
    func createGroup(groupName: String) {
        //THIS IS TEMPORARY
        
        
        let exerciseMaxes = [barbellCurl, benchpress, deadlift, legPress, overheadPress, pushups, squat]
        var x = 0
        for item in exerciseNames {
            createLeaderboardExercise(exercise: item, max: exerciseMaxes[x], groupName: groupName)
            x += 1
        }
        
        db.collection("groups").document(groupName).setData(["DocDescription" : "\(userArray[1])'s group"])
        
        db.collection("groups").document(groupName).collection("maxes").document(userArray[0]).setData([
            "firstname": userArray[1],
            "barbellCurl": barbellCurl,
            "benchpress": benchpress,
            "deadlift": deadlift,
            "legPress": legPress,
            "overheadPress": overheadPress,
            "pushups": pushups,
            "squat": squat
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    //used to fill in the Leaderboard of the group with the exercises and the max date from the user
    func createLeaderboardExercise(exercise: String, max: Int, groupName: String) {
        db.collection("groups").document(groupName).collection("leaderboard").document(exercise).setData([
            userArray[1]: max
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    //gets personal maxes for user, only used in createGroup func at the moment
    func getUserMaxes() {
        let docRef = db.collection("users").document(userArray[0]).collection("personalMaxes").document("personalMaxesDoc")
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataDescription = document.get("benchpress")!
                self.benchpress = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("squat")!
                self.squat = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("barbellCurl")!
                self.barbellCurl = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("overheadPress")!
                self.overheadPress = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("pushups")!
                self.pushups = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("legPress")!
                self.legPress = Int(String(describing: dataDescription)) ?? 0
                dataDescription = document.get("deadlift")!
                self.deadlift = Int(String(describing: dataDescription)) ?? 0
                

            } else {
                print("Document does not exist - user email")
            }
        }
    }
    
    //used to get firstname/lastname/group from email of user
    func getPlayerName() {

        let playerEmail = defaults.string(forKey: "currentUserEmail") ?? "blank@email.com"

        let docRef = db.collection("users").document(playerEmail)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataDescription = document.get("firstname")!
                self.playerFirstName = String(describing: dataDescription)
                dataDescription = document.get("lastname")!
                self.playerLastName = String(describing: dataDescription)
                dataDescription = document.get("group")!
                self.playerGroup = String(describing: dataDescription)
                print("Document data: \(String(describing: dataDescription))")
                //self.scoreL0.text = "\(String(describing: dataDescription))"
            } else {
                print("Document does not exist")
            }
        }

    }
  
    //adding the logout button
    override func viewWillLayoutSubviews() {
       let barButton = UIBarButtonItem()
       barButton.title = "Log Out"
       barButton.action = #selector(barButtonAction)
       barButton.target = self
       self.navigationItem.setRightBarButton(barButton, animated: true)
        
    }
    
    //action function for the the log out button
    @objc func barButtonAction() {
        defaults.set(false, forKey: "stayLoggedInBool")
       print("Attempting to transition to firstVC")
        transitionToView()
    }
    
    //used to log out and transition back to the first view controller
    func transitionToView() {
        
        let vc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.firstViewController) as! ViewController
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    //Imports all personal data for user and all group data for current group
    func importDataMaster() {

        //gets all of the maxes for all of the users and formats them for the array
        db.collection("groups").document(userArray[3]).collection("maxes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.MasterEmailsForMaxes.append(document.documentID)
                    self.subMaxesUserMaxes = document.data()
                    
                    self.subMaxesFirstname = self.subMaxesUserMaxes["firstname"] as? String ?? "BlankName"
                    self.subMaxesBarbellCurl = self.subMaxesUserMaxes["barbellCurl"] as? Int ?? 0
                    self.subMaxesBenchpress = self.subMaxesUserMaxes["benchpress"] as? Int ?? 0
                    self.subMaxesDeadlift = self.subMaxesUserMaxes["deadlift"] as? Int ?? 0
                    self.subMaxesLegPress = self.subMaxesUserMaxes["legPress"] as? Int ?? 0
                    self.subMaxesOverheadPress = self.subMaxesUserMaxes["overheadPress"] as? Int ?? 0
                    self.subMaxesPushups = self.subMaxesUserMaxes["pushups"] as? Int ?? 0
                    self.subMaxesSquat = self.subMaxesUserMaxes["squat"] as? Int ?? 0
                    
                    let tempMaxArray = [self.subMaxesFirstname, self.subMaxesBarbellCurl, self.subMaxesBenchpress, self.subMaxesDeadlift, self.subMaxesLegPress, self.subMaxesOverheadPress, self.subMaxesPushups, self.subMaxesSquat] as [Any]
                    
                    self.MasterMaxes.append(tempMaxArray)
                    //print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        //gets all of the maxes for each workout in the leaderboard section
        db.collection("groups").document(userArray[3]).collection("leaderboard").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.MasterExercises.append(document.documentID)
                    self.MasterLeaderboard.append(document.data())
                    //print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        //gets all of the workout data
        db.collection("groups").document(userArray[3]).collection("workouts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.MasterEmailsForWorkouts.append(document.documentID)
                    self.MasterWorkouts.append(document.data())
                    //print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        
        db.collection("users").document(userArray[0]).collection("personalMaxes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.personalMaxes = (document.data())
                    
                    self.subPersonalMaxesBarbellCurl = self.personalMaxes["barbellCurl"] as? Int ?? 0
                    self.subPersonalMaxesBenchpress = self.personalMaxes["benchpress"] as? Int ?? 0
                    self.subPersonalMaxesDeadlift = self.personalMaxes["deadlift"] as? Int ?? 0
                    self.subPersonalMaxesLegPress = self.personalMaxes["legPress"] as? Int ?? 0
                    self.subPersonalMaxesOverheadPress = self.personalMaxes["overheadPress"] as? Int ?? 0
                    self.subPersonalMaxesPushups = self.personalMaxes["pushups"] as? Int ?? 0
                    self.subPersonalMaxesSquat = self.personalMaxes["squat"] as? Int ?? 0
                    
                    self.MasterPersonalMaxes = [self.subPersonalMaxesBarbellCurl, self.subPersonalMaxesBenchpress, self.subPersonalMaxesDeadlift, self.subPersonalMaxesLegPress, self.subPersonalMaxesOverheadPress, self.subPersonalMaxesPushups, self.subPersonalMaxesSquat] as [Any]
                }
            }
        }
        
        //delay used to add data to master array after retrieving it
        DispatchQueue.main.asyncAfter(deadline: .now() + (importDelay)) {
            self.MasterMaxes.insert(self.MasterEmailsForMaxes, at: 0)
            self.MasterLeaderboard.insert(self.MasterExercises, at: 0)
            self.MasterWorkouts.insert(self.MasterEmailsForWorkouts, at: 0)
            self.MasterGroup = [self.MasterMaxes, self.MasterLeaderboard, self.MasterWorkouts]
            
            self.MasterPersonalInfo = [self.userArray, self.MasterPersonalMaxes]
            
            self.MasterData = [self.MasterPersonalInfo, self.MasterGroup, self.MasterEmailsForMaxes.count]
            
            self.defaults.set(self.MasterData, forKey: "MasterData")
            
            print("THE MASTER ARRAY AHHHH ---> \(self.MasterData)")
        }
        
        
        
    }

}
