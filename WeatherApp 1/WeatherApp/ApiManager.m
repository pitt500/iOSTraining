//
//  ApiManager.m
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ApiManager.h"
#import "Coordinates.h"

@interface ApiManager ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ApiManager

-(void)getWeatherForLocation:(CLLocation *)location
                  useCelcius:(BOOL)useCelcius
       withCompletionHandler:(void (^)(Weather *weather, Coordinates *coords))handler
                   onFailure:(void (^)(NSError *error))onError{
    
                       
    NSString *units = (useCelcius) ? @"metric" : @"imperial";
                       
    //Default location is Hermosillo, Mexico
    NSString * latitude = @"29.066669";
    NSString * longitude =  @"-110.966667";
    
    if (location) {
        longitude = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%.8f",location.coordinate.latitude];
    }
    
    _coordinates = [[Coordinates alloc] initWithLatitude:latitude longitude:longitude];
    
    NSString  *weatherUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=3504cf10781f6cddd3b6f6dd9413694d&units=%@",_coordinates.latitude,_coordinates.longitude,units];
    self.manager = [AFHTTPSessionManager manager];
    
    [self.manager GET:weatherUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id jsonObject) {
        
        NSNumber *temperature = jsonObject[@"main"][@"temp"];
        Weather *aWeather = [[Weather alloc] initWithTemperature:temperature];
        
        if (handler) {
            handler(aWeather,_coordinates);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (handler) {
            handler(nil,nil);
        }
        
        if (onError) {
            onError(error);
        }
        
    }];
    
}

- (void) getDailyForecastWithCoordinates:(Coordinates*) coords
                              useCelcius:(BOOL) useCelcius
                   withCompletionHandler:(void (^)(NSMutableArray *))handler
                                     onFailure:(void (^)(NSError *))onError{
    
    self.coordinates = coords;
    NSString *units = (useCelcius) ? @"metric" : @"imperial";
    NSString  *weatherUrl = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&mode=json&appid=44db6a862fba0b067b1930da0d769e98&units=%@&cnt=7",_coordinates.latitude,_coordinates.longitude,units];
    self.manager = [AFHTTPSessionManager manager];
    
    [self.manager GET:weatherUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id jsonObject) {
        
        NSMutableArray *listForecast = [NSMutableArray array];
        NSArray *jsonListForecast = jsonObject[@"list"];
        
        //Iterating through the entire list of forecast to retrieve the information of each day.
        for (NSDictionary *forecast in jsonListForecast) {
            [listForecast addObject:[[Weather alloc] initWithDictionary:forecast]];
        }
        
        if (handler) {
            handler(listForecast);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (onError) {
            onError(error);
        }
        
    }];

    
}


@end
