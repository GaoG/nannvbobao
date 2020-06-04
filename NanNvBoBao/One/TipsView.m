//
//  TipsView.m
//  Sum
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "TipsView.h"


@interface TipsView ()


@property (weak, nonatomic) IBOutlet UIImageView *answerImage;

@property (weak, nonatomic) IBOutlet UIImageView *tipsImage;


@end

@implementation TipsView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/// 提示  type 1 开始 2请作答
-(void)tipsAction:(int)type {
    
    self.answerImage.hidden = YES;
    self.tipsImage.hidden = NO;
    
    if(type ==1){
        self.tipsImage.image = [UIImage imageNamed:@"one_begin_tips"];
        
        
    }else if (type ==2){
        self.tipsImage.image = [UIImage imageNamed:@"one_respond_tips"];
        
    }else{
        self.tipsImage.image = [UIImage imageNamed:@""];
    }
    
    
    
}

/// 答案 type 1成功 2失败 3 完毕
-(void)answerAction:(int)type {
    self.tipsImage.hidden = YES;
    self.answerImage.hidden =NO ;
    
    if(type ==1){
        self.answerImage.image = [UIImage imageNamed:@"answer_cg"];
    }else if (type ==2){
        self.answerImage.image = [UIImage imageNamed:@"answer_tt"];
    }else if (type ==3){
        self.answerImage.image = [UIImage imageNamed:@"answer_finsh"];
    }else{
        self.answerImage.image = [UIImage imageNamed:@""];
    }
    
    
    
}


@end
