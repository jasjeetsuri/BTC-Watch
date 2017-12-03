//
//  CostTxTableViewCell.swift
//  BTC Watch
//
//  Created by Jas on 20/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class CostTxTableViewCell: UITableViewCell {

  @IBOutlet weak var sentLbl: UILabel!
  @IBOutlet weak var sentBtc: UILabel!
  @IBOutlet weak var costLbl: UILabel!
  
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var dateValue: UILabel!
  
  @IBOutlet weak var costAmount: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
