//
//  CurrencyTableViewCell.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

  //MARK: Outlets
  
  @IBOutlet weak var codeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.reset()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.reset()
  }
  
  func reset() {
    self.codeLabel.text = nil
    self.nameLabel.text = nil
  }
}
