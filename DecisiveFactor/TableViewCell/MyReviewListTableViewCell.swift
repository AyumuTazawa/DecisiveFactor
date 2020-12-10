//
//  MyReviewListTableViewCell.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/11/03.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit

class MyReviewListTableViewCell: UITableViewCell {

    @IBOutlet weak var myReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     func setCell(myReviewData: ReviewData) {
        self.myReview.text = myReviewData.review as String
    }
    
}
