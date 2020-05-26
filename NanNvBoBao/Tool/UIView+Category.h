//
//  UIView+Category.h
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
 @property (nonatomic, assign)CGFloat centerX;
 @property (nonatomic, assign)CGFloat centerY;
 @property (nonatomic, assign)CGSize size;
 @property(nonatomic, assign) IBInspectable CGFloat borderWidth;
 @property(nonatomic, assign) IBInspectable UIColor *borderColor;
 @property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

 /**
  18  *  水平居中
  19  */
 - (void)alignHorizontal;
 /**
  22  *  垂直居中
  23  */
 - (void)alignVertical;
 /**
  26  *  判断是否显示在主窗口上面
  27  *
  28  *  @return 是否
  29  */
 - (BOOL)isShowOnWindow;

 - (UIViewController *)parentController;
@end

NS_ASSUME_NONNULL_END
