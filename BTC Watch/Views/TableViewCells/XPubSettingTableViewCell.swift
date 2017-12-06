//
//  XPubSettingTableViewCell.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

protocol XPubSettingTableViewCellDelegate {
  func xpubTextChanged(withCell cell: XPubSettingTableViewCell)
}

class XPubSettingTableViewCell: UITableViewCell {
  
  //MARK: Outlets
  
  @IBOutlet weak var xpubTextField: UITextField!
  @IBOutlet weak var xpubSettingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.reset()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.reset()
  }
  
  func reset() {
    self.xpubTextField.text = nil
    //self.xpubSettingLabel.text = nil
  }
}
