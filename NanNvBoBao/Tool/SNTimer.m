//
//  SNTimer.m
//  SJLStopWatch
//
//  Created by jinlong sheng on 2018/4/17.
//  Copyright © 2018年 sjl. All rights reserved.
//

#import "SNTimer.h"
@interface SNTimer()
@property (nonatomic, readwrite, copy) void (^block)(void);
@property (nonatomic, readwrite, strong) dispatch_source_t source;
@end

@implementation SNTimer
@synthesize block = _block;
@synthesize source = _source;

+ (SNTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(void))block
{
    NSParameterAssert(seconds);
    NSParameterAssert(block);
    
    SNTimer *timer = [[self alloc] init];
    timer.block = block;
    timer.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                                          dispatch_get_main_queue());
    uint64_t nsec = (uint64_t)(seconds * NSEC_PER_SEC);
    dispatch_source_set_timer(timer.source, dispatch_time(DISPATCH_TIME_NOW, nsec),
                              nsec, 0);
    dispatch_source_set_event_handler(timer.source, block);
 
    return timer;
}
- (void)fire{
    dispatch_resume(self.source);
}
- (void)stop{
    dispatch_suspend(self.source);
}
- (void)invalidate{
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
    self.block = nil;
}
@end
