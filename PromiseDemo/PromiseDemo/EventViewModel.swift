//
//  EventViewModel.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

enum AttendeeMode: Int {
  case AsDriver = 0
  case AsPassanger
  case AsSelectable
}

class EventViewModel: NSObject {
  let eventService = EventService()
  
//  func getAllUpcomingEvents(completion: (listEvents: [ROEvent]) -> Void, onFailure: (error: NSError) -> Void) {
//    
//    eventService.getUpcomingEvents({ (jsonEvents) in
//      let listOfEvents: Array<ROEvent> = Mapper<ROEvent>().mapArray(jsonEvents)!
//      completion(listEvents: listOfEvents)
//    }) { (error) in
//      onFailure(error: error)
//    }
//    
//  }
  
  func getAllUpcomingEvents() -> Promise<[ROEvent]> {
    return eventService.getUpcomingEvents()
      .then { jsonEvents -> [ROEvent] in
        let listOfEvents: [ROEvent] = Mapper<ROEvent>().mapArray(jsonEvents)!
        return listOfEvents
        
      }
  }
}
