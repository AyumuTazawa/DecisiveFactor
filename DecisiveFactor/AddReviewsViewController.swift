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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addReviewsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        addReviewsTextView.delegate = self
        self.name.text = selectedCompanyData.companyName
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addReviewsTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func addReviews(_ sender: Any) {
        firstly {
            self.fechUserData()
        }.done { Udata in
            self.upReviewData(userData: Udata)
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
                    let Udata = UserData.init(udata: data)
                    resolver.fulfill(Udata)
                }
            }
        }
    }
    
    func upReviewData(userData: UserData) -> Promise<Void> {
        return Promise { resolver in
            let writeReview = self.addReviewsTextView.text!
            let writeUser = userData.name
            let companyId = self.selectedCompanyData.postId
            let addreview = ["review": writeReview, "weiteUser": writeUser, "companyId": companyId]
            Firestore.firestore().collection("Reviews").document().setData(addreview) { (err) in
                if let err = err {
                    print(err)
                } else {
                    resolver.fulfill(())
                }
            }
        }
    }
    
}
