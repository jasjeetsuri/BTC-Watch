//
//  Networking.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import Alamofire


enum BTCError: Error, LocalizedError {
  
  case pathNotPresent
  case noData
  
  var localizedDescription: String {
    switch self {
    case .pathNotPresent:
      return NSLocalizedString("path_not_present_error", value: "No path present for request", comment: "No Path present error")
    case .noData:
      return NSLocalizedString("no_data_error", value: "No Data in response", comment: "No data in response error")
    }
  }
}

class Networking {
  
  // MARK: Constants
  
  private static let apiKey = "7GBZiguuFIyOxLDp9wvv33DrUygTFNOIplWLdUotnWgwRKyyeaU25g=="
  
  //RequestGenerator generates a URLRequest ready to be sent, additional API calls can be added by extending the switch statements.
  
  enum RequestRouter: URLRequestConvertible  {
    
    case retrieveBalance
    
    func asURLRequest() throws -> URLRequest {
      
      let baseUrl = "https://btcbalance.azurewebsites.net"
      
      var route: (path: String, parameters: [String: Any], method: HTTPMethod, secure: Bool) {
        switch self {
        case .retrieveBalance:
          let params: [String : Any] = ["code" : apiKey, "xpub" : UserDefaults.standard.string(forKey: "xpub")!, "currency" : UserDefaults.standard.string(forKey: "currency")!]
          return (baseUrl + "/api/balance", params, .get, false)
          
        }
      }
      guard let path = URL(string: route.path) else { throw BTCError.pathNotPresent }
      
      var theURLRequest = URLRequest(url: path, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
      
      theURLRequest.httpMethod = route.method.rawValue
      
      if route.method == .get {
        theURLRequest.httpBody = nil
      }
      
      //return theURLRequest as URLRequest
      var encoding: ParameterEncoding = URLEncoding.default
      
      
      if route.parameters.count > 0 {
        return try encoding.encode(theURLRequest, with: route.parameters)
      }
      return try encoding.encode(theURLRequest, with: nil)
    }
    
    var apiPath: String {
      switch self {
      default:
        return ""
      }
    }
  }
  
  static let instance: Networking = Networking()
  
  var requestManager: Alamofire.SessionManager!
  
  init() {
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 70 // seconds
    configuration.timeoutIntervalForResource = 70
    configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    self.requestManager = Alamofire.SessionManager(configuration: configuration)
  }
  
  // MARK: Methods
  
  class func cancelAllOperations() {
    if #available(iOS 9.0, *) {
      Networking.instance.requestManager.session.getAllTasks { tasks in
        tasks.forEach { $0.cancel() }
      }
    } else {
      Networking.instance.requestManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
        dataTasks.forEach { $0.cancel() }
        uploadTasks.forEach { $0.cancel() }
        downloadTasks.forEach { $0.cancel() }
      }
    }
  }
}



extension Networking {
  
  class func retrieveBalance(withSuccess success: @escaping (_ btc: BTC) -> Void, failure: @escaping (_ error: Error?, _ httpCode: Int?) -> Void) {
    let router = RequestRouter.retrieveBalance
    Networking.instance.requestManager.request(router).responseData{ (response) in
      
      if let error = response.result.error {
        failure(error, response.response?.statusCode)
        return
      } else {
        let jsonData = response.data
        let decoder = JSONDecoder()
        do {
          let balance = try decoder.decode(BTC.self, from: jsonData!)
          success(balance)
        } catch {
          failure(BTCError.noData, nil)
        }
      }
    }
  }
}


