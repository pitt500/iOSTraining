//
//  ROEvent.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//
import ObjectMapper

class ROEvent: Mappable {
  
  var eventId = ""
  var name = ""
  var description = ""
  
  
  
  required init?(_ map: Map) {
    
  }
  
  func mapping(map: Map) {
    eventId         <- map["_id"]
    name            <- map["name"]
    description     <- map["description"]
  }
  
  
}
