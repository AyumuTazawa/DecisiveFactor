//
//  CompanyDetailViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class CompanyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
     @IBOutlet weak var reviewList: UITableView!
     var revirwArray: [ReviewData] = []
     var database: Firestore!
    var selectedCompany: CompayListData!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.CompanyNameLabel.text = selectedCompany.companyName
        
        reviewList.dataSource = self
               reviewList.delegate = self
               reviewList.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
               database = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let companyuid = self.selectedCompany.postId
        database.collection("Companies").document(companyuid).collection("Reviews").addSnapshotListener { (snapshots, err) in
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
        return 70
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
