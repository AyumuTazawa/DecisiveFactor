//
//  MyFavoriteCompanyViewController.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/11/08.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit
import Firebase
import PromiseKit
import XLPagerTabStrip

class MyFavoriteCompanyViewController: UIViewController {
    
    var myPageItemInfo: IndicatorInfo = "FavoriteCompany"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   
    //XLPagerTabStrip
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return myPageItemInfo
    }
    
}
