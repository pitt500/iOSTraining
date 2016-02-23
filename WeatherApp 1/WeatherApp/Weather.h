//
//  Weather.h
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinates.h"

@interface Weather : NSObject

@property(nonatomic, strong) NSNumber* temperature;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSNumber *maxTemperature;
@property(nonatomic,strong) NSNumber *minTemperature;

//@property(nonatomic, strong) Coordinates *coordinates;


- (instancetype)initWithTemperature:(NSNumber *) temperature;
                        //andCoordinates:(Coordinates *) coordinates;


- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@end
