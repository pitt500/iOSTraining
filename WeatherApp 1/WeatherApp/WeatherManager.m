//
//  WeatherManager.m
//  WeatherApp
//
//  Created by projas on 2/14/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager

- (NSNumber*) convertFromFarenheitToCelciusWithTemperature:(NSNumber*) temperature{
    return  @( round((float)( ([temperature floatValue] - 32)*5/9)));
}


- (NSNumber*) convertFromCelciusToFahrenheitWithTemperature:(NSNumber*) temperature{
    return  @(round((float)([temperature floatValue] * 1.8 +32)));
}


@end


