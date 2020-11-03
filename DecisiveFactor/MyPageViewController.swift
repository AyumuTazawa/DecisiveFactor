//
//  MyPageViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/11/03.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase
import PromiseKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var database: Firestore!
    var myReviewPostArray: [ReviewData] = []
    @IBOutlet weak var logInUserName: UILabel!
    @IBOutlet weak var myReviewListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        myReviewListTableView.delegate = self
        myReviewListTableView.dataSource = self
        myReviewListTableView.register(UINib(nibName: "MyReviewListTableViewCell", bundle: nil), forCellReuseIdentifier: "myReviewListCell")
        
       
        self.fechLogInUser().done { Udata in
            self.logInUserName.text = Udata.name
        }.catch { err in
            print(err)
        }
        
        self.fechMyReview().done { myReviewPost in
            self.myReviewPostArray = myReviewPost
            self.myReviewListTableView.reloadData()
        }.catch { err in
            print(err)
        }
       
    }
    
    func fechLogInUser() ->Promise<UserData> {
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
    
    func fechMyReview() -> Promise<[ReviewData]> {
        return Promise { resolver in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let myPageUserId = uid
            database.collection("Reviews").whereField("writeUserId", isEqualTo: myPageUserId).getDocuments { (snapshot,err) in
                if let err = err {
                    print(err)
                }
                if let snapshot = snapshot {
                    print(snapshot.documents)
                    
                    let myReviewPost = snapshot.documents.map {ReviewData(rdata: $0.data())}
                    resolver.fulfill(myReviewPost)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReviewPostArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myReviewCell = tableView.dequeueReusableCell(withIdentifier: "myReviewListCell", for: indexPath) as! MyReviewListTableViewCell
        myReviewCell.setCell(myReviewData: myReviewPostArray[indexPath.row])
        return myReviewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
