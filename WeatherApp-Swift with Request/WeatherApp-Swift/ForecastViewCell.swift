//
//  ForecastViewCellTableViewCell.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/29/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class ForecastViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
