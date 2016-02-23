//
//  ViewController.m
//  LoginFacebook
//
//  Created by projas on 2/16/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FacebookUser.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *facebookTokenLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic,strong) FacebookUser *facebookUser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.facebookUser = [self getUserWithToken];
    if(self.facebookUser){
        [self setLabelsFromUserData];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) loginToFacebook{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         [self checkLoginCasesWithResult:result error:error];
     }];
}

- (void)getUserDataFromFacebook{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email, name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         
         if (!error) {
            NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
            [self saveUserIntoRealmWithResult:result];
            [self setLabelsFromUserData];
         }else{
             NSLog(@"Error: %@",error.description);
         }
     }];

}

- (void) saveUserIntoRealmWithResult:(id)result{
    self.facebookUser = [[FacebookUser alloc] init];
    self.facebookUser.name = result[@"name"];
    self.facebookUser.email = result[@"email"];
    self.facebookUser.tokenId = result[@"id"];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //Add to realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:self.facebookUser];
    [realm commitWriteTransaction];
}

- (void)setLabelsFromUserData{
    
    self.facebookTokenLabel.text = self.facebookUser.tokenId;
    self.usernameLabel.text = self.facebookUser.name;
    self.emailLabel.text = self.facebookUser.email;
    [self.loginButton setTitle:@"Log Out" forState:UIControlStateNormal];
    
}

- (void) removeUserFromRealm{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:[self getUserWithToken]];
    [realm commitWriteTransaction];
}

- (FacebookUser*) getUserWithToken{
    return [[FacebookUser objectsWhere:@"tokenId != ''"] firstObject];
}

-(void) checkLoginCasesWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if (error) {
        NSLog(@"Process error");
    } else if (result.isCancelled) {
        NSLog(@"Cancelled");
    } else {
        NSLog(@"Logged in");
        [self getUserDataFromFacebook];
        [self.loginButton setTitle:@"Log Out" forState:UIControlStateNormal];
    }
}

-(void) cleanLabels{
    self.facebookTokenLabel.text = @"";
    self.usernameLabel.text = @"";
    self.emailLabel.text = @"";
}


#pragma mark - Custom Facebook button
- (IBAction)loginButtonClicked:(id)sender {
    if(self.facebookUser){
        [[FBSDKLoginManager new] logOut];
        [self cleanLabels];
        self.facebookUser = nil;
        [self removeUserFromRealm];
        [sender setTitle:@"Login to Facebook" forState:UIControlStateNormal];
    }else{
        [self loginToFacebook];
    }
}

@end
