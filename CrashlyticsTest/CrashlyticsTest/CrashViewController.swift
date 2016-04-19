//
//  ViewController.swift
//  CrashlyticsTest
//
//  Created by projas on 4/19/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class CrashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func crashApp(sender: AnyObject) {
        let y: String?
        
        y = nil
        print(y!)
    }

}

