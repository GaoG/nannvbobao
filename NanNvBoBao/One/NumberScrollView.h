//
//  NumberScrollView.h
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumberScrollView : UIView

@property (nonatomic, strong)NSMutableArray *selectedStringArr;

@property (nonatomic, strong)NSMutableArray *dataArr;

/// 滚动结束 block
@property (nonatomic, copy)void (^scrollEndBlock) (void);

/// 开始滚动  设置时间
- (void)scrollWithSpace:(float)space andAnmintTime:(float)time;





@end

NS_ASSUME_NONNULL_END
