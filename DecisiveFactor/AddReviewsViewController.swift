//
//  AddReviewsViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/31.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class AddReviewsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addReviewsTextView: UITextView!
    
    var database: Firestore!
    var selectedCompanyData: CompayListData!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        database = Firestore.firestore()
        addReviewsTextView.delegate = self
        self.name.text = selectedCompanyData.companyName
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addReviewsTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func addReviews(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            
            database.collection("users").document(uid).getDocument { (DocumentSnapshot, err) in
                if let err = err {
                    print("ユーザーデータの取得に失敗しました")
                    
                } else {
                    guard let data = DocumentSnapshot?.data() else { return }
                    let Udata = UserData.init(udata: data)
                    print("ユーザーのデータの取得に成功しました\(Udata.name)")
                    let writeReview = self.addReviewsTextView.text!
                    let writeUser = Udata.name
                    let addreview = ["review": writeReview, "weiteUser": writeUser]
                    let companyId = self.selectedCompanyData.postId
                    Firestore.firestore().collection("Companies").document(companyId).collection("Reviews").document().setData(addreview) { (err) in
                        if let err = err {
                            print("レビューの追加に失敗しました")
                        } else {
                            print("レビューの追加に成功しました")
                        }
                        
                    }
                }
            
        }
     
     
    
        
        
    }
    
    

}
