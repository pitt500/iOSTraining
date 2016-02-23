//
//  Player.m
//  Ratings
//
//  Created by projas on 2/4/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Player.h"

@implementation Player

-(UIImage *) imageForRating:(int)rating{
    switch (rating) {
        case 1: return [UIImage imageNamed:@"1Stars"];
        case 2: return [UIImage imageNamed:@"2Stars"];
        case 3: return [UIImage imageNamed:@"3Stars"];
        case 4: return [UIImage imageNamed:@"4Stars"];
        case 5: return [UIImage imageNamed:@"5Stars"];
    }
    
    return nil;
}

@end
