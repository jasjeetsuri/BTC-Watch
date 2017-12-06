//
//  TouchIdTableViewCell.swift
//  BTC Watch
//
//  Created by Jas on 05/12/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class TouchIdTableViewCell: UITableViewCell {
    
    //MARK: Outlets
  @IBOutlet weak var touchIdEnable: UISwitch!
  @IBOutlet weak var touchIdLbl: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      self.reset()
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      self.reset()
    }
    
    func reset() {
      self.touchIdLbl.text = nil
      self.touchIdEnable.isOn = false
    }
}
