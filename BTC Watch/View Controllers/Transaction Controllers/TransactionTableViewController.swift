//
//  TransactionTableViewController.swift
//  BTC Watch
//
//  Created by Jas on 19/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TransactionTableViewController: UITableViewController {
  var count:Int = 0
  var btc = [String]()
  var cost = [String]()
  var profit = [String]()
  var time = [String]()
  var value = [String]()
  var incoming = [String]()
  var gain = [String]()
  
  @IBOutlet var TransactionTable: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        TransactionTable.rowHeight = 90
    TransactionTable.backgroundColor =  UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
        self.retrieveTransactions()
    TransactionTable.separatorColor = UIColor.darkGray
    
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.retrieveTransactions()
    //self.TransactionTable.reloadData()
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return count
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if incoming[indexPath.row] == "true" {
  let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath as IndexPath) as! TransactionTableViewCell
          if count != 0 {
              cell.buyLbl.text = "Received"
              cell.valueLbl.text = "Value"
              cell.costLbl.text = "Cost"
              //cell.dateLbl.text = "Date:"
              //cell.btcLbl.text = "BTC"
              cell.buyBtcValue.text = btc[indexPath.row] + " BTC"
              cell.valueAmount.text = value[indexPath.row]
              cell.costAmount.text = cost[indexPath.row]
              cell.dateTX.text = time[indexPath.row]
              cell.profitPercent.text = profit[indexPath.row]
              cell.selectionStyle = .none
            
            if gain[indexPath.row] == "true"{
              cell.profitPercent.textColor = UIColor.white
              cell.profitPercent.backgroundColor = UIColor(red: 10.0/255.0 , green:  220.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
            }
            if gain[indexPath.row] == "false"{
              cell.profitPercent.textColor = UIColor.white
              cell.profitPercent.backgroundColor = UIColor.red
            }
              cell.profitPercent.layer.masksToBounds = true
              cell.profitPercent.layer.cornerRadius = 7
              return cell
          }
    }
    if incoming[indexPath.row] == "false" {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CostTxTableViewCell", for: indexPath as IndexPath) as! CostTxTableViewCell
      if count != 0 {
        cell.sentLbl.text = "Sent"
        cell.costLbl.text = "Cost"
        cell.dateLbl.text = "Date:"
        //cell.btcLbl.text = "BTC"
        cell.sentBtc.text = btc[indexPath.row] + " BTC"
        cell.sentBtc.textColor = UIColor.red
        cell.costAmount.text = cost[indexPath.row]
        cell.costAmount.textColor = UIColor.red
        cell.dateValue.text = time[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 30.0/255.0 , green:  30.0/255.0 , blue :  30.0/255.0 , alpha: 1.0)
        return cell
      }
    }
    
    
    return UITableViewCell()
    }
  
  func retrieveTransactions() {
    if UserDefaults.standard.string(forKey: "xpub") != "" { 
    Alamofire.request("https://btcbalance.azurewebsites.net/api/transactions?code=ZXXscsYJbbo/UYj68exi9wqSGwc7jIOM5rjyIvV3MVTUDTyzVcVI7Q==&xpub=" + UserDefaults.standard.string(forKey: "xpub")! + "&currency=" + UserDefaults.standard.string(forKey: "currency")!)
      .responseJSON { (responseData) -> Void in
        if((responseData.result.value) != nil) {
          let swiftyJsonVar = JSON(responseData.result.value!)
          //print(swiftyJsonVar.arrayObject![2])
          self.count = swiftyJsonVar.count
          let json = JSON(responseData.result.value!)
          self.btc.removeAll()
          self.cost.removeAll()
          self.profit.removeAll()
          self.time.removeAll()
          self.value.removeAll()
          self.gain.removeAll()
          self.incoming.removeAll()
          
          for (key, subJson) in json {
            //print(subJson["btc"])
            self.btc.append(subJson["btc"].stringValue)
            self.cost.append(subJson["cost"].stringValue)
            self.profit.append(subJson["profit"].stringValue)
            self.time.append(subJson["time"].stringValue)
            self.value.append(subJson["value"].stringValue)
            self.incoming.append(subJson["incoming"].stringValue)
            self.gain.append(subJson["gain"].stringValue)
          }
        }
        self.TransactionTable.reloadData()
    }
  }
  }
}

