//
//  CompayListData.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import Foundation
import Firebase

class CompayListData {
  let companyName: String
  let industry: String
 

  init(data: [String: Any]) {
    
   companyName = data["companyName"] as! String
   industry = data["industry"] as! String
    
  }
}
