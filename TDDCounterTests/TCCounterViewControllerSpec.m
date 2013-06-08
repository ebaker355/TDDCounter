#import "Kiwi.h"

// Collaborators
#import "TCCounterViewController.h"
#import "TCCounter.h"

SPEC_BEGIN(TCCounterViewControllerSpec)

        describe(@"TCCounterViewController", ^{
            __block TCCounterViewController *sut;
            __block id mockCounter;

            beforeEach(^{
                mockCounter = [TCCounter mock];
                [[mockCounter stubAndReturn:@5] valueForKeyPath:@"count"];
                sut = [[TCCounterViewController alloc] initWithCounter:mockCounter];
                [sut view];
            });

            afterEach(^{
                sut = nil;
            });

            context(@"outlets", ^{

                context(@"count label outlet", ^{
                    it(@"should be connected", ^{
                        [[sut countLabel] shouldNotBeNil];
                    });

                    it(@"initial text should be match counter count value", ^{
                        // then
                        [[[[sut countLabel] text] should] equal:@"5"];
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

                    it(@"should trigger only the correct action", ^{
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

                    it(@"should trigger only the correct action", ^{
                        // then
                        [[mockCounter should] receive:@selector(decrement)];

                        // when
                        [sut.minusButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                    });
                });
            });

//            context(@"decrementCount", ^{
//                it(@"should ask counter to decrement", ^{
//                    [[mockCounter should] receive:@selector(decrement)];
//
//                    [sut decrementCount:nil];
//                });
//            });
//
//            context(@"model changed notification", ^{
//                it(@"should update count label", ^{
//                    // given
//                    [[mockCounter should] receive:@selector(count) andReturn:theValue(2)];
//
//                    // when
//                    [[NSNotificationCenter defaultCenter] postNotificationName:TCCounterModelChangedNotification object:mockCounter];
//
//                    // then
//                    [[[[sut countLabel] text] should] equal:@"2"];
//                });
//
//                context(@"from different model", ^{
//                    it(@"should not update count label", ^{
//                        // given
//                        TCCounter *differentCounter = [[TCCounter alloc] init];
//                        [differentCounter setCount:2];
//                        [mockCounter stub:@selector(count) andReturn:theValue(42)];
//
//                        // when
//                        [[NSNotificationCenter defaultCenter] postNotificationName:TCCounterModelChangedNotification object:differentCounter];
//
//                        // then
//                        [[[[sut countLabel] text] should] equal:@"0"];
//                    });
//                });
//            });
        });

SPEC_END
