//
//  ApiManager.m
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ApiManager.h"
#import "Profile.h"
#import "Media.h"

@interface ApiManager ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ApiManager

-(void)getFeedWithTag:(NSString *)instagramTag
    completionHandler:(void (^)(NSArray *profile))handler
            onFailure:(void (^)(NSError *error))onError{

    NSString *instagramFeedUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=005c9a0586834b7bb7335f5955ab951a",instagramTag];
    
    self.manager = [AFHTTPSessionManager manager];
    
    [self.manager GET:instagramFeedUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id jsonObject){
        
        NSArray *jsonFeed = jsonObject[@"data"];
        NSArray *feed = [MTLJSONAdapter modelsOfClass:Profile.class fromJSONArray:jsonFeed error:nil];
        
        if (handler) {
            handler(feed);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error){
        if(onError){
            onError(error);
        }
    }];
}

-(void)geUserMediaWithId:(NSString *)userId
    completionHandler:(void (^)(NSArray *media))handler
            onFailure:(void (^)(NSError *error))onError{
    
    NSString *instagramMediaUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent?client_id=005c9a0586834b7bb7335f5955ab951a",userId];
    
    self.manager = [AFHTTPSessionManager manager];
    
    [self.manager GET:instagramMediaUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id jsonObject){
        
        NSArray *jsonMedia = jsonObject[@"data"];
        NSArray *media = [MTLJSONAdapter modelsOfClass:Media.class fromJSONArray:jsonMedia error:nil];
        
        if (handler) {
            handler(media);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error){
        if(onError){
            onError(error);
        }
    }];
}

@end
