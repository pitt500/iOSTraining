//
//  ProfileCell.h
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Profile;

@interface ProfileCell : UITableViewCell

- (void)configureWithProfile:(Profile *)profile;

@end
