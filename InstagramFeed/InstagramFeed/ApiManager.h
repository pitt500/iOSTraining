//
//  ApiManager.h
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ApiManager : NSObject

-(void)getFeedWithTag:(NSString *)instagramTag
    completionHandler:(void (^)(NSArray *feed))handler
            onFailure:(void (^)(NSError *error))onError;


-(void)geUserMediaWithId:(NSString *)userId
       completionHandler:(void (^)(NSArray *media))handler
               onFailure:(void (^)(NSError *error))onError;

+(id)sharedManager;

@end
