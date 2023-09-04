//
//  FeedViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(.init(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        getDataFromFirestore()
        
    }
    
    
    func getDataFromFirestore(){
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        let documentId = document.documentID

                        if let postedBy = document.get("PostedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let imageUrl = document.get("imageURL") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let comment = document.get("postComment") as? String {
                            self.userCommentArray.append(comment)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
}
extension FeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.PostImageView.image = UIImage(systemName: "pencil")
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.UserEmailLabel.text = userEmailArray[indexPath.row]
        
        return cell
    }
    
    
}

