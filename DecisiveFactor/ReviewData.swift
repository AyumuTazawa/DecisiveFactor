//
//  ReviewData.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/09/01.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import Foundation
import Firebase

class ReviewData {
  let review: String
  let weiteUser: String
 

  init(rdata: [String: Any]) {
    
  review = rdata["review"] as! String
   weiteUser = rdata["weiteUser"] as! String
    
  }
}
