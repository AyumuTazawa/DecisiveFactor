//
//  CompanyListTableViewCell.swift
//  DecisiveFactor
//
//  Created by 田澤歩 on 2020/08/30.
//  Copyright © 2020 net.ayumutazawa. All rights reserved.
//

import UIKit

class CompanyListTableViewCell: UITableViewCell {

    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var ShadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setCell(company: CompayListData) {
           self.companyName.text = company.companyName as String
        self.industry.text = company.industry as String
            
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
    }
    
   
}
