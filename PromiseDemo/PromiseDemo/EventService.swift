//
//  EventService.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//



import Alamofire
import PromiseKit

class EventService {
  let apiService = APIClient()
  
//  func getUpcomingEvents(completion: (jsonEvents: [AnyObject]) -> Void, onFailure: (error: NSError) -> Void){
//    
//    apiService.manager.request(EventRouter.getUpcomingEvents())
//      .responseJSON { (response) in
//        switch response.result{
//        case .Success(let JSON):
//          
//          guard let result = JSON as? [AnyObject]
//            else{
//              
//              onFailure(error: Error.error(code: -1, failureReason: "Bad json received"))
//              return
//          }
//          completion(jsonEvents: result)
//        case .Failure(let error):
//          onFailure(error: error)
//        }
//    }
//  }
  
  func getUpcomingEvents() -> Promise<[[String: AnyObject]]> {
    return Promise { fulfill, reject in
      apiService.manager.request(EventRouter.getUpcomingEvents())
        .responseJSON { response in
          switch response.result{
          case .Success(let JSON):
            fulfill(JSON as! [[String: AnyObject]])
          case .Failure(let error):
            reject(error)
          }
      }
      
    }
  }
  

}
