//
//  APIClient.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import Alamofire

class APIClient {
  static let baseURLString = "http://www.rideas.one/"
  
  var manager: Manager!
  
  init() {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    manager = Alamofire.Manager(configuration: configuration)
  }
  
  static func getFullUrlWithPath(path: String) -> NSURL {
    return NSURL(string: baseURLString + path)!
  }
}
