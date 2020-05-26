//
//  SNTimer.h
//  SJLStopWatch
//
//  Created by jinlong sheng on 2018/4/17.
//  Copyright © 2018年 sjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNTimer : NSObject

+ (SNTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(void))block;

- (void)fire;

- (void)stop;

- (void)invalidate;

@end
