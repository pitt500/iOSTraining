//
//  Weather.m
//  PrintJson
//
//  Created by projas on 2/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)initWithDictionary:(NSDictionary *) JSON
{
    self = [super init];
    if (self) {
        self.temperature = JSON[@"main"][@"temp"];
        self.pressure = JSON[@"main"][@"pressure"];
        self.humidity = JSON[@"main"][@"humidity"];
        self.temperatureMax = JSON[@"main"][@"temp_max"];
        self.temperatureMin = JSON[@"main"][@"temp_min"];
        self.seaLevel = JSON[@"main"][@"sea_level"];
        self.groundLevel = JSON[@"main"][@"grnd_level"];
    }

    return self;
}
@end
