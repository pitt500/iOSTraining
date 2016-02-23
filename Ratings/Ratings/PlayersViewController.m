//
//  PlayersViewController.m
//  Ratings
//
//  Created by projas on 2/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "PlayersViewController.h"
#import "Player.h"
#import "PlayerCell.h"
#import "AboutPlayerViewController.h"

@implementation PlayersViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //If there is no existing cell that can be recycled, this will automatically make a new copy of the prototype cell and return it to you. All you need to do is supply the re-use identifier that you set on the prototype cell in the storyboard editor, in this case PlayerCell.
    
    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    Player *player = self.players[indexPath.row];
    
    
    
    cell.nameLabel.text = player.name;
    [cell.nameLabel sizeToFit];
    
    cell.gameLabel.text = player.game;
    [cell.gameLabel sizeToFit];
    
    cell.ratingImageView.image  = [player imageForRating:player.rating];
    [cell.ratingImageView sizeToFit];
    
    return cell;
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player{
    //This first adds the new Player object to the array of players.
    [self.players addObject:player];
    
    //Then it tells the table view that a new row was added (at the bottom), because the table view and its data source must always be in sync.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.players count] - 1) inSection:0];
    
    //You could have just done [self.tableView reloadData] but it looks nicer to insert the new row with an animation. UITableViewRowAnimationAutomatic automatically picks the proper animation, depending on where you insert the new row. Very handy.
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - For Segue
//The prepareForSegue: method is invoked whenever a segue is about to take place. The new view controller has been loaded from the storyboard at this point but it’s not visible yet, and you can use this opportunity to send data to it.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        PlayerDetailsViewController *playerDetailsViewController = [navigationController viewControllers][0];
        playerDetailsViewController.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"aboutSegue"]) {
        AboutPlayerViewController *aboutPlayerViewController = segue.destinationViewController;
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        Player *player = self.players[selectedIndexPath.row];
        aboutPlayerViewController.player = player;
    }
}

@end
