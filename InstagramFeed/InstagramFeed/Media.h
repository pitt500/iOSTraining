//
//  Media.h
//  InstagramFeed
//
//  Created by projas on 2/24/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface Media : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSURL *imageUrl;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;


@end
