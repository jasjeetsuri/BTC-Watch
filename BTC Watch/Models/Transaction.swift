//
//  Transaction.swift
//  BTC Watch
//
//  Created by Jas on 19/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import Foundation
struct Transaction : Codable {
  var time: String
  var addr: String
  var value: String
  var cost: String
  var profit: String
  var btc: String
  var incoming: String
  var gain: String
}
