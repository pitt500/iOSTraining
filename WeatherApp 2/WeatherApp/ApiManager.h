//
//  ApiManager.h
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>
#import "Weather.h"

@interface ApiManager : NSObject

@property(nonatomic,strong) Coordinates *coordinates;

-(void)getWeatherForLocation:(CLLocation *)location
                  useCelcius:(BOOL) useCelcius
       withCompletionHandler:(void (^)(Weather *weather, Coordinates *coords))handler
                   onFailure:(void (^)(NSError *error))onError;

- (void)getDailyForecastWithCoordinates:(Coordinates*) coords
             useCelcius:(BOOL) useCelcius
                  withCompletionHandler:(void (^)(NSArray *listForecast))handler
                              onFailure:(void(^)(NSError *error))onError;
@end
