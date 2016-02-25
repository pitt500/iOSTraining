//
//  FeedViewController.m
//  InstagramFeed
//
//  Created by projas on 2/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "FeedViewController.h"
#import "ProfileCell.h"
#import "ApiManager.h"
#import "UserDetailController.h"

@interface FeedViewController ()

@property (nonatomic,strong) ApiManager *apiManager;
@property (nonatomic,strong) NSArray <Profile *> *feed;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:@"ProfileCell"];
    self.apiManager = [[ApiManager alloc] init];
    [self getFeedFromInstagram];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getFeedFromInstagram{
    
    NSString *storyboardId = self.restorationIdentifier;
    
    [self.apiManager getFeedWithTag:storyboardId completionHandler:^(NSArray *feed) {
        self.feed = feed;
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@",error.description);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feed count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    Profile *profile = self.feed[indexPath.row];
    [cell configureWithProfile:profile];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //First this deselects the row after it was tapped. That makes it fade from the gray highlight color back to the regular white.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserDetailController *userVC = [[UserDetailController alloc] init];
    userVC.profile = self.feed[indexPath.row];
    
    [self.navigationController pushViewController:userVC animated:YES];
}


@end
