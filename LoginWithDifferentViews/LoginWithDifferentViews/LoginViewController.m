//
//  ViewController.m
//  LoginWithDifferentViews
//
//  Created by projas on 3/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoutViewController.h"
#import "User.h"
#import "NavigationManager.h"
#import <Realm/Realm.h>

@interface LoginViewController ()

@property (nonatomic,strong) NavigationManager *navigationManager;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationManager = [[NavigationManager alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logUserIn:(id)sender {
    [self saveSessionToken];
    [self.navigationManager showLogout];
}

-(void) saveSessionToken{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //Add to realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:[[User alloc] init]];
    [realm commitWriteTransaction];
}


@end
