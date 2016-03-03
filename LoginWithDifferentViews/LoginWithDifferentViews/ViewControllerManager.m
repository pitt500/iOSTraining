//
//  ViewControllerManager.m
//  LoginWithDifferentViews
//
//  Created by projas on 3/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ViewControllerManager.h"
#import <UIKit/UIKit.h>

@implementation ViewControllerManager

+ (instancetype)sharedInstance{
    static ViewControllerManager *sharedMyManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (void)callViewFromStoryboard:(NSString *)storyboardID
              viewControllerID:(NSString *)viewControllerID delegate:(UIViewController*)delegate{
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyboardID bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:viewControllerID];
    
    
    [viewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [delegate presentViewController:viewController animated:YES completion:nil];
}

@end

