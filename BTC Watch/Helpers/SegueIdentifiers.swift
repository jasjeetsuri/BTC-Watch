//
//  SegueIdentifiers.swift
//  uib
//
//  Created by Jasjeet Suri on 06/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

enum SegueIdentifiers: String, SegueIdentityProvider {
  
  case showCurrencySelection = "SegueShowshowCurrencySelectionViewController"
}


/** Compare a segue identifier to one of the SegueIdentifiers */
func == (lhs:UIStoryboardSegue, rhs:SegueIdentityProvider) -> Bool {
  
  if let identifier = lhs.identifier {
    return rhs.rawValue == identifier
  }
  return false
}

func == (lhs:UIStoryboardSegue, rhs:SegueIdentifiers) -> Bool {
  return lhs == rhs as SegueIdentityProvider
}


