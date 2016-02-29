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

static ApiManager *sharedApiManager = nil; //Static insatence variable

#pragma  mark - Singleton methods
+(id)sharedManager{
    if (!sharedApiManager) {
        sharedApiManager = [[ApiManager alloc] init];
    }
    return sharedApiManager;
}

#pragma mark - Methods with callbacks
-(void)getFeedWithTag:(NSString *)instagramTag
    completionHandler:(void (^)(NSArray *profile))handler
            onFailure:(void (^)(NSError *error))onError{

    NSString *instagramFeedUrl = [NSString stringWithFormat:@"%@/tags/%@/media/recent?client_id=%@",BASE_URL_API,instagramTag,CLIENT_ID];
    
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
    
    NSString *instagramMediaUrl = [NSString stringWithFormat:@"%@/users/%@/media/recent?client_id=%@",BASE_URL_API,userId,CLIENT_ID];
    
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
