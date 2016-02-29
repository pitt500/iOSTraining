//
//  ApiManager.h
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define BASE_URL_API    @"https://api.instagram.com/v1"
#define CLIENT_ID   @"005c9a0586834b7bb7335f5955ab951a"

@interface ApiManager : NSObject

-(void)getFeedWithTag:(NSString *)instagramTag
    completionHandler:(void (^)(NSArray *feed))handler
            onFailure:(void (^)(NSError *error))onError;


-(void)geUserMediaWithId:(NSString *)userId
       completionHandler:(void (^)(NSArray *media))handler
               onFailure:(void (^)(NSError *error))onError;

+(id)sharedManager;

@end
