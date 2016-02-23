//
//  PlayersViewController.h
//  Ratings
//
//  Created by projas on 2/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"

@interface PlayersViewController : UITableViewController <PlayerDetailsViewControllerDelegate>

@property(nonatomic,strong) NSMutableArray *players;

@end
