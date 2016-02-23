//
//  WeatherManager.h
//  WeatherApp
//
//  Created by projas on 2/14/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

- (NSNumber*) convertFromFarenheitToCelciusWithTemperature:(NSNumber*) temperature;
- (NSNumber*) convertFromCelciusToFahrenheitWithTemperature:(NSNumber*) temperature;
@end
