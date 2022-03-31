//
//  ViewController.swift
//  LiftGroups
//
//  Created by Wehby, Quinton on 3/3/22.
//

//This is to test commiting from terminal
// testing terminal commit to second branch

//look for this change

import UIKit
import AVKit

class ViewController: UIViewController {


    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    //var player: AVPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // set up video in background
        setUpVideo()
 
    }

   
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    func setUpVideo() {
        
        
        // get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "AlexCurlNA", ofType: "mov")
         
        guard bundlePath != nil else {
            return
        }
        
        //create url from path
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create the video player item
        let item = AVPlayerItem(url: url)
        
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //create the size and frame
        videoPlayerLayer?.frame = CGRect(x: -(self.view.frame.size.width*0.15), y: -(self.view.frame.size.height*0.15), width: self.view.frame.size.width*1.3, height: self.view.frame.size.height*1.3)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add it to view and play it
        playVideo()
        
        //loopVideo1()
        
        
    }
    
    
  
    func playVideo() {
        videoPlayer?.seek(to: CMTime.zero)
        videoPlayer?.playImmediately(atRate: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.playVideo()
            }
    }
    
    func loopVideo1() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { [weak self] _ in
            self?.videoPlayer?.seek(to: CMTime.zero)
            self?.videoPlayer?.playImmediately(atRate: 1)
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        defaults.set(false, forKey: "stayLoggedInBool")
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if defaults.bool(forKey: "stayLoggedInBool") == true {
            transitionToHome()
        } else {
            transitionToLogin()
        }
    }
    
    func transitionToLogin() {
        print("attempting to transition to login screen")
        /*guard let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)*/
        
        //let loginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        //self.view.window?.rootViewController = loginViewController
        //self.view.window?.makeKeyAndVisible()
        
        self.performSegue(withIdentifier: "presentLoginVC", sender: self)
        
    }
    func transitionToHome() {
        print("attempting to transition to home screen")
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }
    
}

