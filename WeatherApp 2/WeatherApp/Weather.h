//
//  Weather.h
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinates.h"
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface Weather : MTLModel <MTLJSONSerializing>

@property(nonatomic, strong) NSNumber* temperature;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSNumber *maxTemperature;
@property(nonatomic,strong) NSNumber *minTemperature;

- (instancetype)initWithTemperature:(NSNumber *) temperature;

@end
