#import "Kiwi.h"

#import "TCCounterViewController.h"

SPEC_BEGIN(TCCounterViewControllerSpec)

        describe(@"TCCounterViewController", ^{
            __block TCCounterViewController *sut;

            beforeEach(^{
                sut = [[TCCounterViewController alloc] init];
                [sut view];
            });

            afterEach(^{
                sut = nil;
            });

            context(@"count label outlet", ^{
                it(@"should be connected", ^{
                    [[sut countLabel] shouldNotBeNil];
                });

                it(@"initial text should be zero (0)", ^{
                    [[[[sut countLabel] text]
                            should] equal:@"0"];
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
                    [[[[sut plusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside]
                            should] equal:@[ @"incrementCount:" ]];
                });
            });

            context(@"incrementCount action", ^{
                context(@"triggered once", ^{
                    beforeEach(^{
                        [sut incrementCount:nil];
                    });

                    it(@"should add one to count label", ^{
                        [[[[sut countLabel] text]
                                should] equal:@"1"];
                    });
                });

                context(@"triggered twice", ^{
                    beforeEach(^{
                        [sut incrementCount:nil];
                        [sut incrementCount:nil];
                    });

                    it(@"should add two to count label", ^{
                        [[[[sut countLabel] text]
                                should] equal:@"2"];
                    });
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
                    [[[[sut minusButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside]
                            should] equal:@[ @"decrementCount:" ]];
                });
            });

            context(@"decrementCount action", ^{
                context(@"triggered once", ^{
                    beforeEach(^{
                        [sut decrementCount:nil];
                    });

                    it(@"should subtract one from count label", ^{
                        [[[[sut countLabel] text]
                                should] equal:@"-1"];
                    });
                });

                context(@"triggered twice", ^{
                    beforeEach(^{
                        [sut decrementCount:nil];
                        [sut decrementCount:nil];
                    });

                    it(@"should subtract two from count label", ^{
                        [[[[sut countLabel] text]
                                should] equal:@"-2"];
                    });
                });
            });
        });

SPEC_END
