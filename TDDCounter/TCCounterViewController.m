//
// Created by Eric Baker on 6/5/13.
// Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TCCounterViewController.h"


@implementation TCCounterViewController
{
    NSInteger _count;
}

- (IBAction)incrementCount:(id)sender
{
    ++_count;
    [self updateCountLabel];
}

- (IBAction)decrementCount:(id)sender
{
    --_count;
    [self updateCountLabel];
}

- (void)updateCountLabel
{
    [_countLabel setText:[@(_count) stringValue]];
}

@end
