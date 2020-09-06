//
//  CompanyDetailViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase
import Nuke

class CompanyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var database: Firestore!
    var revirwArray: [ReviewData] = []
    var selectedCompany: CompayListData!
    
    @IBOutlet weak var reviewList: UITableView!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    @IBOutlet weak var companyOvreviewTextView: UITextView!
    @IBOutlet weak var companyImageImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyImageImageView.layer.cornerRadius = 34
        self.CompanyNameLabel.text = selectedCompany.companyName
        self.companyOvreviewTextView.text = selectedCompany.overview
        if let url = URL(string: selectedCompany.companyImageUrl ?? "" ) {
        Nuke.loadImage(with: url, into: self.companyImageImageView)
            
        }
        reviewList.dataSource = self
               reviewList.delegate = self
               reviewList.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
               database = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let companyuid = self.selectedCompany.postId
        database.collection("companies").document(companyuid).collection("Reviews").addSnapshotListener { (snapshots, err) in
           if err == nil, let snapshots = snapshots {
                        self.revirwArray = []
                     print(snapshots.documents)
                        for document in snapshots.documents {
                            print("成功しました")
                            print(document.data())
                            
                            let data = document.data()
                            let post = ReviewData(rdata: data)
                            self.revirwArray.append(post)
                    
                            self.reviewList.reloadData()
                         
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.revirwArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
         cell.setCell(rdata: revirwArray[indexPath.row])
         return cell
     }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReview" {
            let addReviewContorollre = segue.destination as? AddReviewsViewController
            addReviewContorollre?.selectedCompanyData = self.selectedCompany
            
                   
               }
    }
    

    @IBAction func toReviewContoroller(_ sender: Any) {
        performSegue(withIdentifier: "toReview", sender: nil)
    }
    

}
