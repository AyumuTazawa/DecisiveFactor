//
//  CompanyDetailViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase

class CompanyDetailViewController: UIViewController {
    
    var selectedCompany: CompayListData!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.CompanyNameLabel.text = selectedCompany.companyName
        
    }
    

    

}
