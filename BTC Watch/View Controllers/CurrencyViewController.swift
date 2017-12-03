//
//  CurrencyViewController.swift
//  BTC Watch
//
//  Created by Jas on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
  
  //MARK: Constants
  
  @IBOutlet weak var tableView: UITableView!
  let listName = ["British Pound", "Euro", "US Dollar", "Australian Dollar", "Canadian Dollar", "Chinese Yuan", "Japanese Yen", "New Zealand Dollar", "Swiss Franc"]
  let listCode = ["GBP", "EUR", "USD", "AUD", "CAD", "CNY", "JPY", "NZD", "CHF"]
  
  //MARK: Outlets


  @IBOutlet weak var settingsBackButton: UINavigationItem!
  //MARK: Properties
  
  var data = [String]()
  
  //MARK: Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
    tableView.separatorColor = UIColor.darkGray
    //settingsBackButton.Uol
  }
  
  // MARK: Actions
  
  @IBAction func CancelBtn(_ sender: Any) {
    let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
    tabBarController.selectedIndex = 2
    dismiss(animated: true)
  }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //NSLog("You selected cell number: \(indexPath.row)!")
    let currency = listCode[(indexPath.row)]
    
    if currency != UserDefaults.standard.string(forKey: "currency")!{
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    let defaults = UserDefaults.standard
    defaults.set(currency, forKey: "currency")
    tableView.reloadData()
    let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
    tabBarController.selectedIndex = 2
    dismiss(animated: true) {}
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listName.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyTableViewCell.self)) as! CurrencyTableViewCell
    //cell.textLabel?.text = list[indexPath.row]
    //cell.detailTextLabel?.text = list[indexPath.row]
    cell.nameLabel.text = listName[indexPath.row]
    cell.codeLabel.text = listCode[indexPath.row]
    if listCode[indexPath.row] == UserDefaults.standard.string(forKey: "currency")! {
      cell.accessoryType = .checkmark
    }
    else
    {
      cell.accessoryType = .none
    }
    cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
    return(cell)
  }

}
