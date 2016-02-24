//
//  Profile.h
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface Profile : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic,strong) NSString *fullname;
@property (nonatomic,strong) NSDate *publishDate;
@property (nonatomic,strong) NSURL *profileImageUrl;
@property (nonatomic,strong) NSURL *contentImageUrl;

@end
