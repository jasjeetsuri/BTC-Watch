//
//  NewSettingsViewController.swift
//  BTC Watch
//
//  Created by Jas on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class NewSettingsViewController: UIViewController {
  
  //MARK: Properties
  
  var xpubSetting: String?
  @IBOutlet weak var tableView: UITableView!
  
  //MARK: Outlets
  
 // @IBOutlet weak var xpubSetting: UITextField!
  @IBOutlet weak var myTable: UITableView!
  
  //MARK: Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UINavigationBar.appearance().barStyle = .black
    self.xpubSetting = UserDefaults.standard.string(forKey: "xpub")
    tableView.backgroundColor =  UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
    tableView.separatorColor = UIColor.darkGray
    self.hideKeyboardWhenTappedAround()
      //xpubSetting.delegate = self
  }

  override func viewDidAppear(_ animated: Bool) {
    myTable.reloadData()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}

extension NewSettingsViewController: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if(textField.tag == 0){
      let defaults = UserDefaults.standard
      if let text = textField.text {
        defaults.set(text, forKey: "xpub")
      }
      xpubSetting = textField.text
    }
  }
  //delegate method
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    //self.xpubSetting.resignFirstResponder()
    return true
  }
}

extension NewSettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: XPubSettingTableViewCell.self), for: indexPath as IndexPath) as! XPubSettingTableViewCell
      cell.xpubTextField.delegate = self
      if (UserDefaults.standard.string(forKey: "xpub") == "" ){
        
      } else
      {
        cell.xpubTextField.text = UserDefaults.standard.string(forKey: "xpub")!
      }
      cell.xpubTextField.placeholder = "Enter your xpub"
      cell.xpubSettingLabel.text = "Enter xpub"
      cell.xpubTextField.tag = 0
      cell.xpubTextField.autocorrectionType = UITextAutocorrectionType.no
      cell.xpubTextField.clearButtonMode = UITextFieldViewMode.whileEditing
      cell.xpubTextField.returnKeyType = UIReturnKeyType.done
      cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
      return(cell)
    }
    
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencySettingTableViewCell.self)) as! CurrencySettingTableViewCell
      cell.currencySettingLabel.text = "Currency"
      if (UserDefaults.standard.string(forKey: "currency") == nil ) {
        cell.currencySettingCodeDisplayLabel.text = "GBP"
      } else {
        cell.currencySettingCodeDisplayLabel.text = UserDefaults.standard.string(forKey: "currency")!
      }
      cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
      return(cell)
    }
    return UITableViewCell()
  }
  
  // method to run when table view cell is tapped
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Segue to the second view controller
    if indexPath.row == 1 {
      self.performSegue(.showCurrencySelection, sender: self)
    }
  }
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  func dismissKeyboard() {
    view.endEditing(true)
  }
}
