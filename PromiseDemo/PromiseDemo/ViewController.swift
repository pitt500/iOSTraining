//
//  ViewController.swift
//  PromiseDemo
//
//  Created by projas on 8/23/16.
//  Copyright © 2016 nearsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let eventViewModel = EventViewModel()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    eventViewModel.getAllUpcomingEvents()
      .then { events -> [ROEvent]in
        print(events)
        return events
      }.then { events in
        print("Holaa :\(events[0].name)")
      }.error { error in
        print("Error puto: \(error)")
      }
  }



}

