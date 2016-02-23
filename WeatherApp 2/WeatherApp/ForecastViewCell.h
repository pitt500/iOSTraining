//
//  ForecastViewCell.h
//  WeatherApp
//
//  Created by projas on 2/14/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;

@end
