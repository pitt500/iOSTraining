//
//  PopupViewController.m
//  InstagramFeed
//
//  Created by projas on 2/25/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "PopupViewController.h"
#import "Media.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PopupViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *popupImage;
@property (nonatomic,strong) Media *media;
@end

@implementation PopupViewController

- (instancetype)initWithMedia:(Media *)media
{
    self = [super init];
    if (self) {
        _media = media;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.popupImage setImageWithURL:self.media.imageUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
