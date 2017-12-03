//
//  TransactionTableViewCell.swift
//  BTC Watch
//
//  Created by Jas on 19/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

  @IBOutlet weak var buyLbl: UILabel!
  @IBOutlet weak var buyBtcValue: UILabel!
  @IBOutlet weak var valueLbl: UILabel!
  @IBOutlet weak var valueAmount: UILabel!
  @IBOutlet weak var costLbl: UILabel!
  @IBOutlet weak var costAmount: UILabel!
  @IBOutlet weak var profitPercent: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var dateTX: UILabel!
  //@IBOutlet weak var btcLbl: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      self.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
