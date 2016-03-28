//
//  ViewController.m
//  GoogleSignInTest
//
//  Created by projas on 3/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    NSURL * url = [NSURL URLWithString:@"https://lh4.googleusercontent.com/-igxnU9xjtkI/AAAAAAAAAAI/AAAAAAAAAAs/FkXFVGQVR-o/s100/photo.jpg"];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:data];
    
    self.image.image = image;
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveToggleAuthUINotification:)
     name:@"ToggleAuthUINotification"
     object:nil];
    
    [self toggleAuthUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"ToggleAuthUINotification"
     object:nil];
    
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [self toggleAuthUI];
}

- (void) toggleAuthUI{
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        self.signInButton.hidden = NO;
        self.signOutButton.hidden = YES;
    }else{
        self.signInButton.hidden = YES;
        self.signOutButton.hidden = NO;
    }
}

- (void) receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"ToggleAuthUINotification"]) {
        [self toggleAuthUI];
    }
}

@end
