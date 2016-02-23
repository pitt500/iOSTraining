//
//  Location.m
//  WeatherApp
//
//  Created by projas on 2/11/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Coordinates.h"

@interface Coordinates ()

@end

@implementation Coordinates

- (instancetype)initWithLatitude:(NSString*)latitude
                       longitude:(NSString*)longitude
{
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

@end
