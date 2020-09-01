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
 

  init(udata: [String: Any]) {
    
   name = udata["name"] as! String
   email = udata["email"] as! String
    
  }
}
