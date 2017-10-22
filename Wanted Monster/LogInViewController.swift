
//
//  LogInViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 11/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var LogOrSignSegmentedControl: UISegmentedControl!
    
    @IBAction func logInBtn(_ sender: Any)
    {
        guard let userMail=mailText.text, let userPassword=passwordText.text else{return}
        if LogOrSignSegmentedControl.selectedSegmentIndex==0 //Log In
        {
            //Log In wih Firebase usng the Firebase manager
            FirebaseManager.sharedInstance.logInToApplication(userName: userMail, password: userPassword) { (success, error) in
                if let error = error
                {
                    self.presentAlertDialog(withError: error.localizedDescription)
                }
                if success{
                    self.tabBarController?.selectedIndex=0
                }
            }
        }
        else //Sign In
        {
            //Sign In with the Firebase Manager
            FirebaseManager.sharedInstance.createANewUser(userName: userMail, password: userPassword){ (succes,error) in
            if let error = error
            {
                self.presentAlertDialog(withError: error.localizedDescription)
            }
            if success{
                self.tabBarController?.selectedIndex=0
            }
        }
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ... will Show disconnect button when a user is logged in
        
        }
    }
    
    func presentAlertDialog(withError:String){
        let alertController = UIAlertController(title: "Authentification", message:
            "\(withError)", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.mailText.text=""
            self.passwordText.text=""
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }


