//
//  TipsView.h
//  Sum
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipsView : UIView

//@property (weak, nonatomic) IBOutlet UIButton *tipsLabel;

/// 提示  type 1 开始 2请作答
-(void)tipsAction:(int)type;

/// 答案 type 1成功 2失败 3 完毕
-(void)answerAction:(int)type;

@end

NS_ASSUME_NONNULL_END
