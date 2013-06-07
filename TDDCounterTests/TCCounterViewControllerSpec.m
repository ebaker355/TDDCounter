#import "Kiwi.h"

// Collaborators
#import "TCCounterViewController.h"
#import "TCCounter.h"

@interface TCCounterViewController ()
@property (readonly, nonatomic) IBOutlet UILabel *countLabel;
@property (readonly, nonatomic) IBOutlet UIButton *plusButton;
@property (readonly, nonatomic) IBOutlet UIButton *minusButton;
@end

SPEC_BEGIN(TCCounterViewControllerSpec)

        describe(@"TCCounterViewController", ^{
            __block TCCounterViewController *sut;
            __block id mockCounter;

            beforeEach(^{
                mockCounter = [TCCounter mock];
            });

            context(@"initialized with a counter model where count is 5", ^{

                beforeEach(^{
                    [[mockCounter stubAndReturn:@5] valueForKeyPath:@"count"];

                    sut = [[TCCounterViewController alloc] initWithCounter:mockCounter];
                    [sut view];
                });

                afterEach(^{
                    sut = nil;
                    mockCounter = nil;
                });

                it(@"should display 5 in the label", ^{
                    [[sut.countLabel.text should] equal:@"5"];
                });
            });

            context(@"outlets", ^{
                beforeEach(^{
                    [[mockCounter stubAndReturn:@0] valueForKeyPath:@"count"];

                    sut = [[TCCounterViewController alloc] initWithCounter:mockCounter];
                    [sut view];
                });

                afterEach(^{
                    sut = nil;
                    mockCounter = nil;
                });

                context(@"count label outlet", ^{
                    it(@"should be connected", ^{
                        [[sut countLabel] shouldNotBeNil];
                    });

                    it(@"should be bound to the counter model's count property", ^{
                        // given
                        [[mockCounter stubAndReturn:@10] valueForKeyPath:@"count"];

                        // when
                        [mockCounter willChangeValueForKey:@"count"];
                        [mockCounter didChangeValueForKey:@"count"];

                        // then
                        [[sut.countLabel.text should] equal:@"10"];
                    });
                });

                context(@"plus button outlet", ^{
                    it(@"should be connected", ^{
                        [[sut plusButton] shouldNotBeNil];
                    });

                    it(@"should be labeled +1", ^{
                        [[[[[sut plusButton] titleLabel] text]
                                should] equal:@"+1"];
                    });

                    it(@"should ask the model to increment when touched", ^{
                        // then
                        [[mockCounter should] receive:@selector(increment)];

                        // when
                        [sut.plusButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                    });
                });

                context(@"minus button outlet", ^{
                    it(@"should be connected", ^{
                        [[sut minusButton] shouldNotBeNil];
                    });

                    it(@"should be labeled -1", ^{
                        [[[[[sut minusButton] titleLabel] text]
                                should] equal:@"-1"];
                    });

                    it(@"should ask the model to decrement when touched", ^{
                        // then
                        [[mockCounter should] receive:@selector(decrement)];

                        // when
                        [sut.minusButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                    });
                });
            });
        });

SPEC_END
