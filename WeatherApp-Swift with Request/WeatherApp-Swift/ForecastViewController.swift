//
//  ForecastViewController.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/31/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    var listWeather: [Weather] = []
    var coordinates: Coordinates = Coordinates(WithLatitude: "-110.966667", longitude: "29.066669")
    var useCelcius: Bool = true
    let dayTimePeriodFormatter =  NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayTimePeriodFormatter.dateFormat = "EEEE"
        self.getForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getForecast() -> Void {
        WeatherViewModel.getDailyForecast(WithCoordinates: self.coordinates, useCelcius: self.useCelcius, completion: { (forecast) in
            self.listWeather = forecast
            self.tableView.reloadData()
        }) { (error) in
            print("Error getting forecast. \(error.description)")
        }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWeather.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ForecastViewCell = tableView.dequeueReusableCellWithIdentifier("ForecastCell", forIndexPath: indexPath) as! ForecastViewCell
        let forecastForADay = self.listWeather[indexPath.row]
        let dateString = dayTimePeriodFormatter.stringFromDate(forecastForADay.date!)
        
        cell.dayLabel.text = dateString
        cell.minTemperatureLabel.text = String(format: "%.0f", round(forecastForADay.minTemperature))+"°"
        cell.maxTemperatureLabel.text = String(format: "%.0f", round(forecastForADay.maxTemperature))+"°"

        return cell
    }
}
