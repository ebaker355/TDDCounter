//
// Created by Eric Baker on 6/5/13.
// Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface TCCounter : NSObject

@property (assign, nonatomic) NSInteger count;

- (void)increment;
- (void)decrement;

@end
