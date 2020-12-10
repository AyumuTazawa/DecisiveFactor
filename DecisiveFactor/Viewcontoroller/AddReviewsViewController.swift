//
//  AddReviewsViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/31.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase
import PromiseKit

class AddReviewsViewController: UIViewController, UITextViewDelegate {
    
    var database: Firestore!
    var selectedCompanyData: CompayListData!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var addReviewsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        addReviewsTextView.delegate = self
        self.companyName.text = selectedCompanyData.companyName
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addReviewsTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func addReviews(_ sender: Any) {
        firstly {
            self.fechUserData()
        }.done { writeUserData in
            self.upReviewData(userData: writeUserData)
        }.catch { err in
            print(err)
        }
    }
    
    func fechUserData() -> Promise<UserData> {
        return Promise { resolver in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            database.collection("users").document(uid).getDocument { (documentSnapshot, err) in
                if let err = err {
                    print(err)
                } else {
                    guard let data = documentSnapshot?.data() else { return }
                    let writeUserData = UserData.init(userData: data)
                    resolver.fulfill(writeUserData)
                }
            }
        }
    }
    
    func upReviewData(userData: UserData) -> Promise<Void> {
        return Promise { resolver in
            let writeReview = self.addReviewsTextView.text!
            let writeUser = userData.name
            let writeUserId = userData.userId
            let companyId = self.selectedCompanyData.postId
            let saveReview = Firestore.firestore().collection("reviews").document()
            let reviewId = saveReview.documentID
            let addreviewData = ["review": writeReview, "writeUser": writeUser,"writeUserId": writeUserId, "companyId": companyId, "reviewId": reviewId]
            saveReview.setData(addreviewData) { (err) in
                if let err = err {
                    print(err)
                } else {
                    resolver.fulfill(())
                }
            }
        }
    }
    
}
