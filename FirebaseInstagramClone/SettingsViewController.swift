//
//  SettingsViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toViewContoller", sender: nil)
    }
   

}
