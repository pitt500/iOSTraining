//
//  Weather.h
//  PrintJson
//
//  Created by projas on 2/3/16.
//  Copyright © 2016 projas. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Weather : NSObject


@property(nonatomic, strong) NSNumber* temperature;
@property(nonatomic, strong) NSNumber* pressure;
@property(nonatomic, strong) NSNumber* humidity;
@property(nonatomic, strong) NSNumber* temperatureMin;
@property(nonatomic, strong) NSNumber* temperatureMax;
@property(nonatomic, strong) NSNumber* seaLevel;
@property(nonatomic, strong) NSNumber* groundLevel;

- (instancetype)initWithDictionary:(NSDictionary *) JSON;

@end
