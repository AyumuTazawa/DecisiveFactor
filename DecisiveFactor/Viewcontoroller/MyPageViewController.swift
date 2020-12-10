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
    var selectReview: ReviewData!
    var updataTextFilde: UITextField!
    var myReviewPostArray: [ReviewData] = []
    @IBOutlet weak var myReviewListTableView: UITableView!
    @IBOutlet weak var logInUserName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        myReviewListTableView.delegate = self
        myReviewListTableView.dataSource = self
        myReviewListTableView.register(UINib(nibName: "MyReviewListTableViewCell", bundle: nil), forCellReuseIdentifier: "myReviewListCell")
        
        //ログイン中のユーザーのデータを反映
        self.fostLoginUserData()
        //自分の投稿したReviewを反映
        self.fostReviewsData()
        
    }
    
    func fostLoginUserData() {
        self.fechLogInUser().done { loginUserdata in
            self.logInUserName.text = loginUserdata.name
        }.catch { err in
            print(err)
        }
    }
    
    func fostReviewsData() {
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
                    let loginUserdata = UserData.init(userData: data)
                    resolver.fulfill(loginUserdata)
                }
            }
        }
    }
    
    func fechMyReview() -> Promise<[ReviewData]> {
        return Promise { resolver in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let myPageUserId = uid
            database.collection("reviews").whereField("writeUserId", isEqualTo: myPageUserId).getDocuments { (snapshot,err) in
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
    
    //レビューの更新を実行
    func runUpdateReview() {
        firstly {
            self.upDateTitle()
        }.done {
            self.fostReviewsData()
        }.catch { err in
            print(err)
        }
    }
    
    //Firestore更新
    func upDateTitle() -> Promise<Void> {
        return Promise { resolver in
            let updateReview = self.updataTextFilde.text
            let ref = Firestore.firestore().collection("reviews").document(self.selectReview.reviewId)
            ref.updateData(["review": updateReview]) { (err) in
                if let err = err {
                    print(err)
                } else {
                    resolver.fulfill(())
                }
            }
        }
    }
    
    //レビューの更新を実行
    func runDeleteReview() {
        firstly {
            self.deleteMyReview()
        }.done {
            self.fostReviewsData()
        }.catch { err in
            print(err)
        }
    }
    
    //Firestore削除
    func deleteMyReview() -> Promise<Void> {
        return Promise { resolver in
            Firestore.firestore().collection("reviews").document(self.selectReview.reviewId).delete(){ (err) in
                if let err = err {
                    print(err)
                } else {
                    resolver.fulfill(())
                }
            }
        }
    }
    
    //更新・削除スワイプボタン
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 更新
        let upDateAction = UITableViewRowAction(style: .default, title: "更新"){ action, indexPath in
            self.selectReview = self.myReviewPostArray[indexPath.row]
            self.updateReview()
        }
        //削除
        let deleteAction = UITableViewRowAction(style: .default, title: "削除"){ action, indexPath in
            //Firebaseからも削除
            self.selectReview = self.myReviewPostArray[indexPath.row]
            //self.deleteMyReview()
            self.deleteReview()
        }
        return [upDateAction, deleteAction]
    }
    
    //更新
    func updateReview() {
        //アラートを表示
        let alertController: UIAlertController = UIAlertController(title: "レビューを更新", message: "更新する文章を入力してください", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { action -> Void in
        }
        alertController.addAction(cancelAction)
        let addAction: UIAlertAction = UIAlertAction(title: "更新", style: .default) { action -> Void in
            //レビューの更新を実行
            self.runUpdateReview()
        }
        alertController.addAction(addAction)
        alertController.addTextField { textField -> Void in
            textField.placeholder = "追加するテキスト"
            self.updataTextFilde = textField
        }
        present(alertController, animated: true, completion: nil)
    }
    
    //削除
    func deleteReview() {
        //アラートを表示
        let alertController: UIAlertController = UIAlertController(title: "削除しますか", message: "削除する場合は削除ボタンを押してください", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { action -> Void in
        }
        alertController.addAction(cancelAction)
        let addAction: UIAlertAction = UIAlertAction(title: "削除", style: .default) { action -> Void in
            //レビューの削除を実行
            self.runDeleteReview()
        }
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReviewPostArray.count
    }
    
    //以下tableViewの設定
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
