//
//  ApiManager.m
//  PrintJson
//
//  Created by projas on 2/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ApiManager.h"
#import <AFNetworking/AFNetworking.h>


@implementation ApiManager


-(void)getWeatherWithCompletationHandler:(void (^)(Weather *))block onFailure:(void (^)(NSError *))onError{
    NSLog(@"===1");
    
    NSString  *weatherUrl = @"http://api.openweathermap.org/data/2.5/weather?q=London&appid=44db6a862fba0b067b1930da0d769e98";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:weatherUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id jsonObject) {
        Weather *weather = [[Weather alloc] initWithDictionary:jsonObject[@"main"]];
        
        if (block) {
            block(weather);
        }
        
        NSLog(@"%@",jsonObject[@"main"]);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (onError) {
            onError(error);
        }
    }];
    
    NSLog(@"===End");
    
}

-(void)getWeatherWithCompletationHandler:(void (^)(Weather *))block{
    
    
    
}

@end
