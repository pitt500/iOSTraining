//
//  ForecastTableViewController.h
//  WeatherApp
//
//  Created by projas on 2/14/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coordinates.h"

@interface ForecastTableViewController : UITableViewController

@property (nonatomic,strong) Coordinates *coordinates;
@property (nonatomic,assign) BOOL useCelcius;

@end
