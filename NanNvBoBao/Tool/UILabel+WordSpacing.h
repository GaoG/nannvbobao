//
//  UILabel+WordSpacing.h
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WordSpacing)

-(void)setText:(NSString *)text withKeyWord:(NSArray *)keywords withKeyColor:(UIColor *)color;


-(void)setText:(NSString *)text withWordSpacing:(float)spacing;

@end

NS_ASSUME_NONNULL_END
