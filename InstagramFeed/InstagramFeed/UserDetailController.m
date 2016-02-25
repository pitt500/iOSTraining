//
//  UserViewController.m
//  InstagramFeed
//
//  Created by projas on 2/24/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "UserDetailController.h"
#import "Profile.h"
#import "Media.h"
#import "MediaViewCell.h"
#import "ApiManager.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface UserDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *mediaCollection;

@property (nonatomic, strong) ApiManager *apiManager;
@property (nonatomic,strong) NSArray<Media *> *mediaArray;

@end

@implementation UserDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiManager = [[ApiManager alloc] init];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    

    [self.mediaCollection registerNib:[UINib nibWithNibName:@"MediaViewCell" bundle:nil] forCellWithReuseIdentifier:@"MediaViewCell"];
    
    [self.userImage setImageWithURL:self.profile.profileImageUrl];
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@",self.profile.username];
    self.fullnameLabel.text = self.profile.fullname;
    
    [self getUserMedia];
    
    
    // Do any additional setup after loading the view from its nib.
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserMedia{
    [self.apiManager geUserMediaWithId:self.profile.Id completionHandler:^(NSArray *media) {
        self.mediaArray = media;
        [self.mediaCollection reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@",error.description);
    }];
}




#pragma mark - Collection View Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.mediaArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MediaViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MediaViewCell" forIndexPath:indexPath];
    
    Media *media = self.mediaArray[indexPath.row];
    [cell.imageView setImageWithURL:media.imageUrl];
    return cell;
}

#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

@end
