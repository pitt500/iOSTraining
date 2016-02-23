//
//  Weather.m
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)initWithTemperature:(NSNumber *)temperature{
    self = [super init];
    if (self) {
        self.temperature = @(round([temperature floatValue]));
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.date = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"dt"] floatValue]];
        self.temperature = dictionary[@"temp"][@"day"];
        self.minTemperature = @(round([dictionary[@"temp"][@"min"] floatValue]));
        self.maxTemperature = @(round([dictionary[@"temp"][@"max"] floatValue]));
        
    }
    return self;
}

@end
