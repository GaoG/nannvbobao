//
//  StartView.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "StartView.h"
@interface StartView ()


@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;



@end
@implementation StartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 配置颜色
- (void)configColor:(NSInteger )type {
    
    if(type ==1){
        // 默认
        self.bgImageView.image = [UIImage imageNamed:@""];
        self.logoImageView.image = [UIImage imageNamed:@""];
        
        
    }else if (type ==2){
        // 金色
        self.bgImageView.image = [UIImage imageNamed:@""];
        self.logoImageView.image = [UIImage imageNamed:@""];
        
    }

    
    
    
    
}




@end
