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

            beforeEach(^{
                sut = [[TCCounter alloc] init];
            });

            afterEach(^{
                sut = nil;
            });

            context(@"increment 1", ^{
                beforeEach(^{
                    [sut setCount:1];
                    [sut increment];
                });

                it(@"should yield 2", ^{
                    [[@([sut count]) should] equal:@2];
                });
            });

            context(@"increment 2", ^{
                beforeEach(^{
                    [sut setCount:1];
                    [sut increment];
                    [sut increment];
                });

                it(@"should yield 3", ^{
                    [[@([sut count]) should] equal:@3];
                });
            });

            context(@"increment", ^{
                __block NotificationListener *notificationListener;

                beforeEach(^{
                    notificationListener = [[NotificationListener alloc] init];
                    [[NSNotificationCenter defaultCenter]
                            addObserver:notificationListener selector:@selector(counterModelChanged:) name:TCCounterModelChangedNotification object:sut];
                });

                afterEach(^{
                    [[NSNotificationCenter defaultCenter]
                            removeObserver:notificationListener];
                    notificationListener = nil;
                });

                it(@"should post model changed notification", ^{
                    // when
                    [sut increment];

                    // then
                    [[@([notificationListener modelChangedCount]) should] equal:@1];
                });

                it(@"should post notification with new count", ^{
                    // given
                    [sut setCount:1];

                    // when
                    [sut increment];

                    // then
                    [[@([notificationListener modelChangedValue]) should] equal:@2];
                });
            });

            context(@"decrement 1", ^{
                beforeEach(^{
                    [sut setCount:1];
                    [sut decrement];
                });

                it(@"should yield 0", ^{
                    [[@([sut count]) should] equal:@0];
                });
            });

            context(@"decrement 2", ^{
                beforeEach(^{
                    [sut setCount:1];
                    [sut decrement];
                    [sut decrement];
                });

                it(@"should yield -1", ^{
                    [[@([sut count]) should] equal:@-1];
                });
            });

            context(@"increment", ^{
                __block NotificationListener *notificationListener;

                beforeEach(^{
                    notificationListener = [[NotificationListener alloc] init];
                    [[NSNotificationCenter defaultCenter]
                            addObserver:notificationListener selector:@selector(counterModelChanged:) name:TCCounterModelChangedNotification object:sut];
                });

                afterEach(^{
                    [[NSNotificationCenter defaultCenter]
                            removeObserver:notificationListener];
                    notificationListener = nil;
                });

                it(@"should post model changed notification", ^{
                    // when
                    [sut decrement];

                    // then
                    [[@([notificationListener modelChangedCount]) should] equal:@1];
                });

                it(@"should post notification with new count", ^{
                    // given
                    [sut setCount:1];

                    // when
                    [sut decrement];

                    // then
                    [[@([notificationListener modelChangedValue]) should] equal:@0];
                });
            });
        });

SPEC_END
