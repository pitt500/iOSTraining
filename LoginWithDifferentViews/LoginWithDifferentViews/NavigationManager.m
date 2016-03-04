//
//  NavigationManager.m
//  LoginWithDifferentViews
//
//  Created by projas on 3/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "NavigationManager.h"
#import "AppDelegate.h"
#import "User.h"
#import "LoginViewController.h"
#import "LogoutViewController.h"

@interface NavigationManager ()

@end

@implementation NavigationManager

- (BOOL) isUserLogged{
    if([[User objectsWhere:@"isLogged == YES"] firstObject]){
        return YES;
    }
    
    return NO;
}

- (void)showLogout{
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIStoryboard *coreStoryBoard = [UIStoryboard storyboardWithName:@"Core" bundle:nil];
    LogoutViewController *logout = [coreStoryBoard instantiateViewControllerWithIdentifier:@"LogoutViewController"];
    myAppDelegate.window.rootViewController = logout;
    
    [UIView transitionWithView:myAppDelegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ myAppDelegate.window.rootViewController = logout; }
                    completion:nil];
}

- (void)showLogin{
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIStoryboard *welcomeStoryBoard = [UIStoryboard storyboardWithName:@"Welcome" bundle:nil];
    LoginViewController *login = [welcomeStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myAppDelegate.window.rootViewController = login;
    
    [UIView transitionWithView:myAppDelegate.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ myAppDelegate.window.rootViewController = login; }
                    completion:nil];
    
}

//UIModalTransitionStyleCoverVertical

@end
