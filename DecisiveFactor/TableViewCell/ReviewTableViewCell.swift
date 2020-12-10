//
//  ReviewTableViewCell.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/09/01.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyReviewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(rdata: ReviewData) {
        self.companyReviewTextView.text = rdata.review as String
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
