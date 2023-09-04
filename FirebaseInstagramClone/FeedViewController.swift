//
//  FeedViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(.init(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
       
    }
    
}
extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.commentLabel.text = "Commet 1"
        cell.PostImageView.image = UIImage(systemName: "pencil")
        cell.likeLabel.text = "Like : 5"
        cell.UserEmailLabel.text = "test@gmail.com"
        
        return cell
    }
    
    
}

