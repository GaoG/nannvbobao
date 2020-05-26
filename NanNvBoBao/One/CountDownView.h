//
//  CountDownView.h
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountDownView : UIView

/// 倒计时结束block
@property (nonatomic, copy) void (^endBlock)(void);
/// 倒计时开始
-(void)countDownBegin:(NSInteger)tempSecond;

@end

NS_ASSUME_NONNULL_END
