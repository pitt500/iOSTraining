//
//  EventRouter.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import Alamofire

enum EventRouter: URLRequestConvertible {
  
  
  case getUpcomingEvents()
  case getPastEvents()
  case addNewEvent(event: ROEvent)
  case getEventWithId(eventId: String)
  
  var method: Alamofire.Method{
    switch self {
    case .getUpcomingEvents,
         .getPastEvents,
         .getEventWithId:
      return .GET
    case .addNewEvent:
      return .POST
    }
  }
  
  var path: String{
    switch self {
    case .getUpcomingEvents, .addNewEvent:
      return "api/events"
    case .getPastEvents:
      return "api/events/past"
    case .getEventWithId(let eventId):
      return "api/events/\(eventId)"
    }
  }
  
  private var parameters: [String: AnyObject]?{
    switch self {
    case .addNewEvent(let event):
      return [
        "name"        : event.name,
        "description" : event.description
      ]
      
    case .getPastEvents, .getUpcomingEvents, .getEventWithId:
      return nil
    }
  }
  
  private var encoding: ParameterEncoding?{
    switch self {
    case .addNewEvent:
      return Alamofire.ParameterEncoding.JSON
    case .getPastEvents, .getUpcomingEvents, .getEventWithId:
      return nil
    }
  }
  
  var URLRequest: NSMutableURLRequest{
    let url = APIClient.getFullUrlWithPath(path)
    let mutableURLRequest = NSMutableURLRequest(URL: url)
    mutableURLRequest.HTTPMethod = method.rawValue
    
    
    let token = "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU3NGU4MjE0OWY3ZDllMTEwMDg4MTg0YSIsImlhdCI6MTQ3MDMzMjYxMiwiZXhwIjo0NjIzOTMyNjEyLCJpc3MiOiJvbmUucmlkZWFzLmFwaSJ9.uRaEelilnKzm3KvQSKLUmmHMTwgNmlP7lLk2mh-hZ-k"
    mutableURLRequest.setValue(token, forHTTPHeaderField: "Authorization")
    
    
    if let encoding = self.encoding {
      return encoding.encode(mutableURLRequest, parameters: self.parameters).0
    }
    
    return mutableURLRequest
  }
  
}
