//
// Created by Eric Baker on 6/5/13.
// Copyright (c) 2013 DuneParkSoftware, LLC. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>

@interface TCCounterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

- (IBAction)incrementCount:(id)sender;
- (IBAction)decrementCount:(id)sender;

@end
