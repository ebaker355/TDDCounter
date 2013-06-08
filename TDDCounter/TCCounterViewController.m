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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up RAC bindings
    RAC(_countLabel, text) = [RACSignal combineLatest:@[RACAbleWithStart(_counter, count)]
                                               reduce:^(NSNumber *number) {
                                                   return [number stringValue];
                                               }];

    RACCommand *incrementCommand = [RACCommand command];
    [incrementCommand subscribeNext:^(id sender) {
        [_counter increment];
    }];
    [[self.plusButton rac_signalForControlEvents:UIControlEventTouchUpInside] executeCommand:incrementCommand];

    RACCommand *decrementCommand = [RACCommand command];
    [decrementCommand subscribeNext:^(id sender) {
        [_counter decrement];
    }];
    [[self.minusButton rac_signalForControlEvents:UIControlEventTouchUpInside] executeCommand:decrementCommand];
}

@end
