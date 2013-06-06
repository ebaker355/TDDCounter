//
// Created by Eric Baker on 6/5/13.
// Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TCCounterViewController.h"
#import "TCCounter.h"

@implementation TCCounterViewController
{
    TCCounter *_counter;
}

- (id)initWithCounter:(TCCounter *)counter
{
    self = [super init];
    if (self) {
        _counter = counter;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelChanged:) name:TCCounterModelChangedNotification object:_counter];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self modelChanged:nil];
}

- (void)modelChanged:(NSNotification *)notification
{
    [_countLabel setText:[@([_counter count]) stringValue]];
}

- (IBAction)incrementCount:(id)sender
{
    [_counter increment];
}

- (IBAction)decrementCount:(id)sender
{
    [_counter decrement];
}

@end
