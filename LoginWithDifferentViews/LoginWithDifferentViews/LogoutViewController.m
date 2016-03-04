//
//  LogoutViewController.m
//  LoginWithDifferentViews
//
//  Created by projas on 3/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "LogoutViewController.h"
#import "LoginViewController.h"
#import "NavigationManager.h"
#import <Realm/Realm.h>

@interface LogoutViewController ()

@property (nonatomic,strong) NavigationManager *navigationManager;

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationManager = [[NavigationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLogout:(id)sender {
    [self deleteSessionToken];
    [self.navigationManager showLogin];
    
}

- (void) deleteSessionToken{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
