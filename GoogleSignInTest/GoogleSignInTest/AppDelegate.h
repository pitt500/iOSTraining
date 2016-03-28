//
//  AppDelegate.h
//  GoogleSignInTest
//
//  Created by projas on 3/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

