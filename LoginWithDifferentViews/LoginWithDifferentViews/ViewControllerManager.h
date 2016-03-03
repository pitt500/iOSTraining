//
//  ViewControllerManager.h
//  LoginWithDifferentViews
//
//  Created by projas on 3/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface ViewControllerManager : NSObject

+ (instancetype)sharedInstance;

- (void)callViewFromStoryboard:(NSString *)storyboardID
              viewControllerID:(NSString *)viewControllerID delegate:(UIViewController*)delegate;

@end
