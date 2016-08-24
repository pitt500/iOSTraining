//
//  Helpers.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import Alamofire

extension Error{
  static func error(domain domain: String = Error.Domain, code: Code, failureReason: String) -> NSError {
    return error(domain: domain, code: code.rawValue, failureReason: failureReason)
  }
  
  static func error(domain domain: String = Error.Domain, code: Int, failureReason: String) -> NSError {
    let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
    return NSError(domain: domain, code: code, userInfo: userInfo)
  }
}