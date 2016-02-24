//
//  Profile.m
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Profile.h"
#import <MTLValueTransformer.h>

@implementation Profile

+(NSDictionary *) JSONKeyPathsByPropertyKey{
    return @{
        @"Id": @"user.id",
        @"username": @"user.username",
        @"fullname": @"user.full_name",
        @"publishDate": @"caption.created_time",
        @"profileImageUrl": @"caption.from.profile_picture",
        @"contentImageUrl": @"images.low_resolution.url"
    };
}

+ (NSValueTransformer *)publishDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.publishDateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)publishDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}


+ (NSValueTransformer *)profileImageUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *url, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:url];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return [url absoluteString];
    }];
}

+ (NSValueTransformer *)contentImageUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *url, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:url];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return [url absoluteString];
    }];
}

@end
