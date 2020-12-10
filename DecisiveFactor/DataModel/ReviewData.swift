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
    let writeUser: String
    let writeUserId: String
    let companyId: String
    let reviewId: String

  init(rdata: [String: Any]) {
    
    review = rdata["review"] as! String
    writeUser = rdata["writeUser"] as! String
    writeUserId = rdata["writeUserId"] as! String
    companyId = rdata["companyId"] as! String
    reviewId = rdata["reviewId"] as! String
    
  }
}
