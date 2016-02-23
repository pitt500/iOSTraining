//
//  Weather.m
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Weather.h"
#import <MTLValueTransformer.h>

@implementation Weather

- (instancetype)initWithTemperature:(NSNumber *)temperature{
    self = [super init];
    if (self) {
        _temperature = @(round([temperature floatValue]));
    }
    return self;
}


+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
        @"date": @"dt",
        @"temperature": @"temp.day",
        @"minTemperature": @"temp.min",
        @"maxTemperature": @"temp.max"
    };
}

// mapping birthday to NSDate and vice-versa
+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}

+ (NSValueTransformer *)temperatureJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *temp, BOOL *success, NSError *__autoreleasing *error) {
        return @(round([temp floatValue]));
    } reverseBlock:^id(NSNumber *temperature, BOOL *success, NSError *__autoreleasing *error) {
        return [temperature stringValue];
    }];
}

+ (NSValueTransformer *)minTemperatureJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *temp, BOOL *success, NSError *__autoreleasing *error) {
         return @(round([temp floatValue]));
    } reverseBlock:^id(NSNumber *temperature, BOOL *success, NSError *__autoreleasing *error) {
        return [temperature stringValue];
    }];
}

+ (NSValueTransformer *)maxTemperatureJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *temp, BOOL *success, NSError *__autoreleasing *error) {
        return @(round([temp floatValue]));
    } reverseBlock:^id(NSNumber *temperature, BOOL *success, NSError *__autoreleasing *error) {
        return [temperature stringValue];
    }];
}


@end
