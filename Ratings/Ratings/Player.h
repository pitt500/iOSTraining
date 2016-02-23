//
//  Player.h
//  Ratings
//
//  Created by projas on 2/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

@interface Player : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *game;
@property (nonatomic, assign) int rating;

-(UIImage *) imageForRating:(int)rating;

@end
