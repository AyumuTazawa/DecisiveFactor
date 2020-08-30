//
//  CompanyListViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class CompanyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var companyList: UITableView!
       var database: Firestore!
       var postArray: [CompayListData] = []
    var selectedText: String?
       
    


    override func viewDidLoad() {
        super.viewDidLoad()

        companyList.dataSource = self
        companyList.delegate = self
        companyList.register(UINib(nibName: "CompanyListTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyListCell")
        // 初期値代入
        database = Firestore.firestore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        database.collection("Companies").getDocuments { (snapshot, err) in
                   if err == nil, let snapshot = snapshot {
                       self.postArray = []
                    print(snapshot.documents)
                       for document in snapshot.documents {
                           print("成功しました")
                           print(document.data())
                           
                           let data = document.data()
                           let post = CompayListData(data: data)
                           self.postArray.append(post)
                   
                           self.companyList.reloadData()
                        
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
        return self.postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyListCell", for: indexPath) as! CompanyListTableViewCell
        cell.setCell(company: postArray[indexPath.row])
        
        // add border and color
               cell.backgroundColor = UIColor.white
               cell.layer.borderColor = UIColor.black.cgColor
               cell.layer.borderWidth = 1
               cell.layer.cornerRadius = 8
               cell.clipsToBounds = true
        
        return cell
    }
    
    
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toDetail",sender: nil)
            // セルの選択を解除
                   tableView.deselectRow(at: indexPath, animated: true)
                   
    }
    
    //値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
        //次の画面の取得
        let detailViewContorollre = segue.destination as! CompanyDetailViewController
        let selectedIndex = companyList.indexPathForSelectedRow!
        detailViewContorollre.selectedCompany = postArray[selectedIndex.row]
        
    }
    }
    
}
