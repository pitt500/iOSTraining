//
//  ApiManager.h
//  PrintJson
//
//  Created by projas on 2/3/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface ApiManager : NSObject

- (void)getWeatherWithCompletationHandler:(void (^)(Weather *weather))block  onFailure:(void (^)(NSError *error))onError;

@end
