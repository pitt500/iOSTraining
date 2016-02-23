//
//  Location.h
//  WeatherApp
//
//  Created by projas on 2/11/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinates : NSObject

@property(nonatomic, strong) NSString* latitude;
@property(nonatomic, strong) NSString* longitude;



- (instancetype)initWithLatitude:(NSString*)latitude
                       longitude:(NSString*)longitude;
@end
