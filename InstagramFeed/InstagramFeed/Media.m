//
//  Media.m
//  InstagramFeed
//
//  Created by projas on 2/24/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "Media.h"
#import <MTLValueTransformer.h>

@implementation Media

+(NSDictionary *) JSONKeyPathsByPropertyKey{
    return @{
         @"imageUrl": @"images.standard_resolution.url",
         @"width": @"images.standard_resolution.width",
         @"height": @"images.standard_resolution.height",
    };
}


+ (NSValueTransformer *)imageUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *url, BOOL *success, NSError *__autoreleasing *error) {
        return [NSURL URLWithString:url];
    } reverseBlock:^id(NSURL *url, BOOL *success, NSError *__autoreleasing *error) {
        return [url absoluteString];
    }];
}


@end
