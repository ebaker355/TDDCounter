#import "Kiwi.h"

#import "TCCounter.h"

@interface KVOObserver : NSObject
@property (strong, nonatomic) NSString *changedKeyPath;
@end

@implementation KVOObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setChangedKeyPath:keyPath];
}
@end

SPEC_BEGIN(TCCounterSpec)

        describe(@"TCCounter", ^{
            __block TCCounter *sut;
            __block KVOObserver *fakeObserver;

            beforeEach(^{
                sut = [[TCCounter alloc] init];
                [sut setCount:1];

                fakeObserver = [[KVOObserver alloc] init];
                [sut addObserver:fakeObserver forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
            });

            afterEach(^{
                [sut removeObserver:fakeObserver forKeyPath:@"count"];
                fakeObserver = nil;

                sut = nil;
            });

            context(@"increment", ^{
                it(@"should trigger KVO observers", ^{
                    // when
                    [sut increment];

                    // then
                    [[[fakeObserver changedKeyPath] should] equal:@"count"];
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
                it(@"should trigger KVO observers", ^{
                    // when
                    [sut decrement];

                    // then
                    [[[fakeObserver changedKeyPath] should] equal:@"count"];
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
