//
//  FeedViewController.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIDArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(.init(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")
        getDataFromFirestore()
        
    }
    
    
    func getDataFromFirestore(){
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").order(by: "Date",descending: true) //Orderby kısmı date e göre sıralamak için kullanılıyor.
            .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        self.documentIDArray.append(documentId)

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
        cell.PostImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.UserEmailLabel.text = userEmailArray[indexPath.row]
        cell.documentIdLabel.text = documentIDArray[indexPath.row]
        
        
        return cell
    }
    
    
}

