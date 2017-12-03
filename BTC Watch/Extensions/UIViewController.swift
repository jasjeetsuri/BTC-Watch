//
//  UIViewController.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
  /** Performs a segue */
  func performSegue(_ withIdentifier: SegueIdentifiers, sender: Any? = nil) {
    self.performSegue(withIdentifier: withIdentifier.rawValue, sender: sender)
  }
  
  func performSegue(_ withIdentifier: SegueIdentityProvider, sender: Any? = nil) {
    self.performSegue(withIdentifier: withIdentifier.rawValue, sender: sender)
  }
}
