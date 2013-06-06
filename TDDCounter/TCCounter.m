//
// Created by Eric Baker on 6/5/13.
// Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TCCounter.h"

NSString *const TCCounterModelChangedNotification = @"TCCounterModelChangedNotification";

@implementation TCCounter

- (void)increment
{
    _count += 1;
    [self postModelChangedNotification];
}

- (void)decrement
{
    _count -= 1;
    [self postModelChangedNotification];
}

- (void)postModelChangedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TCCounterModelChangedNotification object:self];
}

@end
