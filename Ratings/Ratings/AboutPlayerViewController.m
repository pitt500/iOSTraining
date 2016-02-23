//
//  AboutPlayerViewController.m
//  Ratings
//
//  Created by projas on 2/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "AboutPlayerViewController.h"
#import "Player.h"

@interface AboutPlayerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;

@end

@implementation AboutPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerName.text = self.player.name;
    [self.playerName sizeToFit];
    
    self.gameName.text = self.player.game;
    [self.gameName sizeToFit];
    
    self.ratingImage.image = [self.player imageForRating:self.player.rating];
    [self.ratingImage setContentMode:UIViewContentModeCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 1;
}
@end
