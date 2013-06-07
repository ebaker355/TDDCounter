#import "Kiwi.h"

#import "TCCounter.h"

@interface NotificationListener : NSObject
@property (assign, nonatomic) NSInteger modelChangedCount, modelChangedValue;

- (void)counterModelChanged:(NSNotification *)notification;
@end

@implementation NotificationListener
- (void)counterModelChanged:(NSNotification *)notification
{
    ++_modelChangedCount;
    TCCounter *counter = (TCCounter *)[notification object];
    _modelChangedValue = [counter count];
}
@end

SPEC_BEGIN(TCCounterSpec)

        describe(@"TCCounter", ^{
            __block TCCounter *sut;
            __block NotificationListener *notificationListener;

            beforeEach(^{
                sut = [[TCCounter alloc] init];
                [sut setCount:1];

                notificationListener = [[NotificationListener alloc] init];
                [[NSNotificationCenter defaultCenter]
                        addObserver:notificationListener selector:@selector(counterModelChanged:) name:TCCounterModelChangedNotification object:sut];
            });

            afterEach(^{
                [[NSNotificationCenter defaultCenter]
                        removeObserver:notificationListener];
                notificationListener = nil;

                sut = nil;
            });

            context(@"increment", ^{
                it(@"should post model changed notification", ^{
                    // when
                    [sut increment];

                    // then
                    [[@([notificationListener modelChangedCount]) should] equal:@1];
                });

                it(@"should post notification with new count", ^{
                    // when
                    [sut increment];

                    // then
                    [[@([notificationListener modelChangedValue]) should] equal:@2];
                });

                context(@"once", ^{
                    it(@"should yield 2", ^{
                        // when
                        [sut increment];

                        // then
                        [[@([sut count]) should] equal:@2];
                    });
                });

                context(@"twice", ^{
                    it(@"should yield 3", ^{
                        // when
                        [sut increment];
                        [sut increment];

                        // then
                        [[@([sut count]) should] equal:@3];
                    });
                });
            });

            context(@"decrement", ^{
                it(@"should post model changed notification", ^{
                    // when
                    [sut decrement];

                    // then
                    [[@([notificationListener modelChangedCount]) should] equal:@1];
                });

                it(@"should post notification with new count", ^{
                    // when
                    [sut decrement];

                    // then
                    [[@([notificationListener modelChangedValue]) should] equal:@0];
                });

                context(@"once", ^{
                    it(@"should yield 0", ^{
                        // when
                        [sut decrement];

                        // then
                        [[@([sut count]) should] equal:@0];
                    });
                });

                context(@"twice", ^{
                    it(@"should yield -1", ^{
                        // when
                        [sut decrement];
                        [sut decrement];

                        // then
                        [[@([sut count]) should] equal:@-1];
                    });
                });
            });
        });

SPEC_END
