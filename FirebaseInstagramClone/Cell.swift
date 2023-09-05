//
//  Cell.swift
//  FirebaseInstagramClone
//
//  Created by Furkan Deniz Albaylar on 4.09.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class Cell: UITableViewCell {

    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var UserEmailLabel: UILabel!
    @IBOutlet weak var PostImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDataBase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["likes" : likeCount + 1]  as [String : Any]
            fireStoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge:true)
        }
        
        
    }
}
