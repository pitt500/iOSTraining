//
//  PlayerDetailsViewController.m
//  Ratings
//
//  Created by projas on 2/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "PlayerDetailsViewController.h"
#import "Player.h"

@interface PlayerDetailsViewController ()

@end

@implementation PlayerDetailsViewController
{
    NSString *_game;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"init PlayerDetailsViewController");
        _game = @"Chess";
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailLabel.text = _game;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //This just says that if the user tapped in the first cell, the app should activate the text field. There is only one cell in the section so you only need to test for the section index. Making the text field the first responder will automatically bring up the keyboard. It’s just a little tweak, but one that can save users a bit of frustration.
    if (indexPath.section == 0) {
        [self.nameTextField becomeFirstResponder];
    }
}

- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)game{
    _game = game;
    self.detailLabel.text = _game;
    
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - Buttons
- (IBAction)cancel:(id)sender{
    [self.delegate playerDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender{
    
    Player *player = [[Player alloc] init];
    player.name = self.nameTextField.text;
    player.game = _game;
    player.rating = 1;
    [self.delegate playerDetailsViewController:self didAddPlayer:player];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //This time the destination view controller is the game picker screen. prepareForSegue: happens after GamePickerViewController is instantiated but before its view is loaded, so the self.game property already has the game’s name by the time GamePickerViewController gets to viewDidLoad.
    if ([segue.identifier isEqualToString:@"PickGame"]) {
        GamePickerViewController *gamePickerViewController = segue.destinationViewController;
        gamePickerViewController.delegate = self;
        gamePickerViewController.game = _game;
    }
}

@end
