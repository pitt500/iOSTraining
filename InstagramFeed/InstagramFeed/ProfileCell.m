//
//  ProfileCell.m
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ProfileCell.h"
#import "Profile.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NSDate+TimeAgo.h"

@interface ProfileCell ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *imageToShow;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithProfile:(Profile *)profile{
    [self.profileImage setImageWithURL:profile.profileImageUrl];
    [self.imageToShow setImageWithURL:profile.contentImageUrl];
    
    self.usernameLabel.text = profile.username;
    self.fullnameLabel.text = profile.fullname;
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[profile.publishDate timeAgoSimple]];
}

@end
