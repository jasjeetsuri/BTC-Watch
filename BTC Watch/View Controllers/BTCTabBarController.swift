//
//  BTCTabBarController.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 23/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class BTCTabBarController: UITabBarController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.setUp()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setUp()
  }
  
  func setUp() {
    self.delegate = self
  }
}

extension BTCTabBarController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let tabBarIndex = tabBarController.selectedIndex
    if tabBarIndex == 0 {
      if let overViewVC = self.viewControllers?[0] as? OverviewViewController {
        overViewVC.retrieveBalance()
      }
    }
    let secondVC = tabBarController.viewControllers?[2] as! UINavigationController
    secondVC.popToRootViewController(animated: false)
  }
}
