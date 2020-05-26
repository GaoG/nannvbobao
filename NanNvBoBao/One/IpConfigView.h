//
//  IpConfigView.h
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IpConfigView : UIView

/// type 1提交  2测试
@property (nonatomic, copy)void (^connectBlock)(NSString *ID,NSString *mainIP,NSString *listIP,NSString *audienceIP, NSInteger type);

@end

NS_ASSUME_NONNULL_END
