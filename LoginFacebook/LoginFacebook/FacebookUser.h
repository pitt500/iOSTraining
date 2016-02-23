//
//  FacebookUser.h
//  LoginFacebook
//
//  Created by projas on 2/18/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <Realm/Realm.h>

@interface FacebookUser : RLMObject

@property NSString *tokenId;
@property NSString *name;
@property NSString *email;

@end
