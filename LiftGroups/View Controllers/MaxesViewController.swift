//
//  MaxesViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/22/22.
//

import UIKit
import Firebase

class MaxesViewController: UIViewController {
    
    
    @IBOutlet weak var benchpressField: UITextField!
    @IBOutlet weak var squatField: UITextField!
    @IBOutlet weak var barbellCurlField: UITextField!
    @IBOutlet weak var legPressField: UITextField!
    @IBOutlet weak var deadliftField: UITextField!
    @IBOutlet weak var overheadPressField: UITextField!
    @IBOutlet weak var pushupField: UITextField!
    
    let db = Firestore.firestore()
    var userArray = [String]()
    let defaults = UserDefaults.standard
    
    var barbellCurl = 1
    var benchpress = 1
    var deadlift = 1
    var legPress = 1
    var overheadPress = 1
    var pushups = 1
    var squat = 1
    let exerciseNames = ["barbellCurl", "benchpress", "deadlift", "legPress", "overheadPress", "pushups", "squat"]
    
    var MasterData = [Any]()
    var MasterPersonalInfo = [Any]()
    var MasterPersonalMaxes = [Any]()
    
    var MasterGroup = [Any]()
    var MasterLeaderboard = [Any]()
    
    var subLeaderboardArray = [[String : Int]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        importMasterData()
        setIndividualMaxes()
        fillFields()
        
        
        userArray = defaults.stringArray(forKey: "userArray") ?? ["ERR: CouldNotGetArray", "", "", ""]
        print(userArray)
        
    }
    
    //def not the best way to do this, especially regarding leaderboard, ok for now tho
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        barbellCurl = Int(barbellCurlField.text!) ?? 0
        benchpress = Int(benchpressField.text!) ?? 0
        deadlift = Int(deadliftField.text!) ?? 0
        legPress = Int(legPressField.text!) ?? 0
        overheadPress = Int(overheadPressField.text!) ?? 0
        pushups = Int(pushupField.text!) ?? 0
        squat = Int(squatField.text!) ?? 0
        
        createLeaderboardExercise()
        saveMaxes()
        savePersonalMaxes()
        
    }
    
    //ok with this for now
    func saveMaxes() {
        db.collection("groups").document(userArray[3]).collection("maxes").document(userArray[0]).setData([
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
    
    //Should work now
    func createLeaderboardExercise() {
        let exerciseMaxes = [barbellCurl, benchpress, deadlift, legPress, overheadPress, pushups, squat]
        subLeaderboardArray = [["" : 0], ["" : 0], ["" : 0], ["" : 0], ["" : 0], ["" : 0], ["" : 0]]
        
        MasterGroup = MasterData[1] as? [Any] ?? ["ERROR1: MasterData not found", "Err"]
        MasterLeaderboard = MasterGroup[1] as? [Any] ?? ["ERROR2: MasterData not found", "Err", "Err", "Err", "Err", "Err", "Err"]
        
        var x = 1
        while x <= 7 {
            var tempArray = MasterLeaderboard[x] as? [String : Int] ?? ["ERROR3: MasterData not found" : 0]
            tempArray[userArray[1]] = exerciseMaxes[x-1]
            
            subLeaderboardArray[x-1] = tempArray
            
            x += 1
        }
        
        print("Sorted leaderboard array with all exercises \(subLeaderboardArray)")
        
        var y = 0
        for exercise in exerciseNames {
            db.collection("groups").document(userArray[3]).collection("leaderboard").document(exercise).setData(
                subLeaderboardArray[y]
            ) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            y += 1
        }
        
    }
    
    //ok with this for now
    func savePersonalMaxes() {
        
        db.collection("users").document(userArray[0]).collection("personalMaxes").document("personalMaxesDoc").setData([
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
    
    //ok with this for now
    func fillFields() {
        barbellCurlField.text = "\(barbellCurl)"
        benchpressField.text = "\(benchpress)"
        deadliftField.text = "\(deadlift)"
        legPressField.text = "\(legPress)"
        overheadPressField.text = "\(overheadPress)"
        pushupField.text = "\(pushups)"
        squatField.text = "\(squat)"
    }
    
    func importMasterData() {
        MasterData = defaults.array(forKey: "MasterData") ?? ["ERROR: No master data found6"]
    }
    
    func setIndividualMaxes() {
        MasterPersonalInfo = MasterData[0] as? [Any] ?? ["ERROR: MasterData not found7", "Err"]
        MasterPersonalMaxes = MasterPersonalInfo[1] as? [Any] ?? ["ERROR: MasterData not found8 - 2"]
        
        barbellCurl = MasterPersonalMaxes[0] as? Int ?? 0
        benchpress = MasterPersonalMaxes[1] as? Int ?? 0
        deadlift = MasterPersonalMaxes[2] as? Int ?? 0
        legPress = MasterPersonalMaxes[3] as? Int ?? 0
        overheadPress = MasterPersonalMaxes[4] as? Int ?? 0
        pushups = MasterPersonalMaxes[5] as? Int ?? 0
        squat = MasterPersonalMaxes[6] as? Int ?? 0
        
        MasterGroup = MasterData[1] as? [Any] ?? ["ERROR9: MasterData not found", "Err"]
    }
    
    //not needed here actually - does nothing USEFUL at the moment
    func sortArray(array: [String : Int]) -> [Any] {
        let mySortedArray = array.sorted { (first, second) -> Bool in
            return first.value > second.value
        }

        return mySortedArray
    }

}
