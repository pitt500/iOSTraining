//
//  ViewController.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
  let eventViewModel = EventViewModel()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    eventViewModel.getAllUpcomingEvents()
      .then { events -> Promise<[ROEvent]>in
        
        print("1")
        print(events)
        return self.eventViewModel.getAllUpcomingEvents()
      }.recover{ (error) -> Promise<[ROEvent]> in
        print("2")
        print(error)
        return self.eventViewModel.getAllUpcomingEvents()
      }
      .then { events -> Void in
        print("3")
        print("Holaa :\(events[0].name)")
      }.error { error -> Void in
        print("4")
        print("Error puto: \(error)")
      }
    
  }



}

