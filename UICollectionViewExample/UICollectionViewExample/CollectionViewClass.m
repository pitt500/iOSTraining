//
//  CollectionViewClass.m
//  UICollectionViewExample
//
//  Created by projas on 2/23/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "CollectionViewClass.h"
#import "MyCollectionViewCell.h"

@interface CollectionViewClass ()
@property (nonatomic,strong) NSArray *collectionImages;

@end

@implementation CollectionViewClass

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionImages = [NSArray arrayWithObjects:@"image1.png",
                             @"image2.png",
                             @"image3.png",
                             @"image4.png",
                             @"image5.png",
                             @"image6.png",
                             @"image7.png",
                             @"image8.png",
                             @"image9.png",
                             @"image10.png",
                             @"image11.png", nil];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"Cell";
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    UIImageView *collectionImageView = (UIImageView *)[cell viewWithTag:100];
//    collectionImageView.image = [UIImage imageNamed:[self.collectionImages objectAtIndex:indexPath.row]];
    
    cell.imageView.image = [UIImage imageNamed:[self.collectionImages objectAtIndex:indexPath.row]];
    
    //self.foodImage.image = [UIImage imageNamed:[self.collectionImages objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(100, 100);
    return mElementSize;
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
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

@end
