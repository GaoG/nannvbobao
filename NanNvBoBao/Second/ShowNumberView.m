//
//  ShowNumberView.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ShowNumberView.h"
#import "UILabel+WordSpacing.h"
@interface ShowNumberView ()
/// 这个label 翻转会有问题
@property (weak, nonatomic) IBOutlet UILabel *NumberL;

@property (nonatomic, strong)UILabel *mirrorLabel;



@end

@implementation ShowNumberView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
//    [self.NumberL setText:@"123" withWordSpacing:50.0];
    
    
    
    
}


/// type 1白色  2黄色
-(void)setText:(NSString *)text andColor:(NSInteger )type {
    
    
    if(type == 2){
        [self.mirrorLabel setTextColor:UIColor.yellowColor];
        
    }else{
        [self.mirrorLabel setTextColor:UIColor.whiteColor];
    }
    
    
     [self.mirrorLabel setText:text withWordSpacing:50.0];
    [self ceshi: type == 2 withView:self.mirrorLabel];
   
}


-(void)ceshi:(BOOL)state withView:(UIView *)view {
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.duration = 0.0001;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat: state ? 3.1415926 : 0.0];
    [view.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
}



-(UILabel *)mirrorLabel {
    
    if (!_mirrorLabel) {
        _mirrorLabel = [[UILabel alloc]initWithFrame:self.NumberL.bounds];
        [self.NumberL addSubview:self.mirrorLabel];
//        self.mirrorLabel.backgroundColor = UIColor.redColor;

            }
    
    return _mirrorLabel;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
