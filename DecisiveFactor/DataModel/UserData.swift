//
//  UserData.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/31.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import Foundation
import Firebase

class UserData {
    
    let name: String
    let email: String
    let userId: String
 
  init(userData: [String: Any]) {
    
    name = userData["name"] as! String
    email = userData["email"] as! String
    userId = userData["userId"] as! String
    
    }
}
