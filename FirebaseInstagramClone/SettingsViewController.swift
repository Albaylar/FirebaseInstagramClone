//
//  SettingsViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewContoller", sender: nil)
        } catch {
            print("Error")
        }
        
    }
   

}
