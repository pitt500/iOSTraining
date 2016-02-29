//
//  UserViewController.h
//  InstagramFeed
//
//  Created by projas on 2/24/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Profile;
@class Media;

@interface UserDetailController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) Profile *profile;

@end
