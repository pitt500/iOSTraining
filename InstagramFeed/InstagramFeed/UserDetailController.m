//
//  UserViewController.m
//  InstagramFeed
//
//  Created by projas on 2/24/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "UserDetailController.h"
#import "Profile.h"
#import "Media.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UserDetailController ()

@property(nonatomic,strong) Media *media;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;


@end

@implementation UserDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.userImage setImageWithURL:self.profile.profileImageUrl];
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@",self.profile.username];
    self.fullnameLabel.text = self.profile.fullname;
    // Do any additional setup after loading the view from its nib.
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
