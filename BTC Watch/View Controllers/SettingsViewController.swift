//
//  SettingsViewController.swift
//  BTC Watch
//
//  Created by Jas on 11/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  //MARK: Outlets
  
  @IBOutlet weak var xpubSetting: UITextField!
  
  //MARK: Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    xpubSetting.delegate = self
    xpubSetting.text = UserDefaults.standard.string(forKey: "xpub")
    
    let defaults = UserDefaults.standard
    
    defaults.set(self.xpubSetting.text, forKey: "xpub")
    //xpubSetting.text = "xpub6CmMZDsUyrmXjpexBPqZtSny3nhb7ZVuhKKhbgMmLmVHtMxgudFViFj2exncDcRxRQkSP4SbDUG8tkxXrjzCUtBFJ6wQMUKqahizLA1fUPL"
        // Do any additional setup after loading the view.
  }
  
  // MARK: Actions
  
  @IBAction func changeXpub(_ sender: Any) {
    //let defaults = UserDefaults.standard
    //defaults.set(self.xpubSetting.text, forKey: "xpub")
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.xpubSetting.endEditing(true)
  }
}

extension SettingsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
    self.xpubSetting.endEditing(true)
    return true
  }
}
