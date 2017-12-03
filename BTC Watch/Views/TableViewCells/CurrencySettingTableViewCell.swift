//
//  CurrencySettingTableViewCell.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class CurrencySettingTableViewCell: UITableViewCell {
  
  //MARK: Outlets
  
  @IBOutlet weak var currencySettingCodeDisplayLabel: UILabel!
  @IBOutlet weak var currencySettingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.reset()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.reset()
  }
  
  func reset() {
    self.currencySettingCodeDisplayLabel.text = nil
    self.currencySettingLabel.text = nil
  }
}
