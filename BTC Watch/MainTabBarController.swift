//
//  MainTabBarController.swift
//  BTC Watch
//
//  Created by Jas on 22/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
      func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // im my example the desired view controller is the second one
        // it might be different in your case...
        let secondVC = tabBarController.viewControllers?[1] as! UINavigationController
        secondVC.popToRootViewController(animated: false)
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
