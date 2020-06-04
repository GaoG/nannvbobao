//
//  SubmitView.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "SubmitView.h"
#import "SNTimer.h"
@interface SubmitView ()

/// 计时器
@property (weak, nonatomic) IBOutlet UILabel *chronographL;


@property (weak, nonatomic) IBOutlet UILabel *minuteL;

@property (weak, nonatomic) IBOutlet UILabel *minuteR;


@property (weak, nonatomic) IBOutlet UILabel *secondL;

@property (weak, nonatomic) IBOutlet UILabel *secondR;


@property (weak, nonatomic) IBOutlet UILabel *msecL;

@property (weak, nonatomic) IBOutlet UILabel *msecR;

@property (weak, nonatomic) IBOutlet UILabel *msecS;

/// 提交
@property (weak, nonatomic) IBOutlet UIButton *submitBut;

@property (nonatomic,strong) SNTimer *gcdTimer;

@property (nonatomic,strong) NSDate * date1970;

@property (nonatomic,strong) NSDate * startCountDate;

@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@property (nonatomic, assign) int time;

@end

@implementation SubmitView



/// 倒计时开始
- (void)start {
    self.submitBut.enabled = YES;
    self.startCountDate = [NSDate date];
    
    [_gcdTimer invalidate];
    __weak id weakSelf = self;
    self.date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:0.0001 block:^{
        [weakSelf updateTime];
    }];
    
    
    [self.gcdTimer fire];
  
}



-(void)updateTime {
    
    NSTimeInterval timeDieff = [[[NSDate alloc]init]timeIntervalSinceDate:self.startCountDate];
    NSDate * timeToShow = [NSDate date];
    
    timeToShow = [self.date1970 dateByAddingTimeInterval:timeDieff];
    
    
    NSString *strDate = [self.dateFormatter stringFromDate:timeToShow];
//    NSLog(@"%@ ===",strDate);
    
    _chronographL.text = strDate;
    
    _minuteL.text=[strDate substringWithRange:NSMakeRange(0, 1)];
    _minuteR.text=[strDate substringWithRange:NSMakeRange(1, 1)];
    
    _secondL.text=[strDate substringWithRange:NSMakeRange(3, 1)];
    _secondR.text=[strDate substringWithRange:NSMakeRange(4, 1)];

    _msecL.text=[strDate substringWithRange:NSMakeRange(6, 1)];
//    _msecM.text=[strDate substringWithRange:NSMakeRange(4, 1)];
    _msecR.text=[strDate substringWithRange:NSMakeRange(7, 1)];
    _msecS.text = [strDate substringWithRange:NSMakeRange(8, 1)];
}









-(void)delayAction {
    
    NSTimeInterval timeDieff = [[[NSDate alloc]init]timeIntervalSinceDate:self.startCountDate];
    NSDate * timeToShow = [NSDate date];
    
    timeToShow = [self.date1970 dateByAddingTimeInterval:timeDieff];
    
    
    NSString *strDate = [self.dateFormatter stringFromDate:timeToShow];
    //    NSLog(@"%@ ===",strDate);
    
    _chronographL.text = strDate;
    
    _minuteL.text=[strDate substringWithRange:NSMakeRange(0, 1)];
    _minuteR.text=[strDate substringWithRange:NSMakeRange(1, 1)];
    
    _secondL.text=[strDate substringWithRange:NSMakeRange(3, 1)];
    _secondR.text=[strDate substringWithRange:NSMakeRange(4, 1)];
    
    _msecL.text=[strDate substringWithRange:NSMakeRange(6, 1)];
    //    _msecM.text=[strDate substringWithRange:NSMakeRange(4, 1)];
    _msecR.text=[strDate substringWithRange:NSMakeRange(7, 1)];
    
    _msecS.text=[strDate substringWithRange:NSMakeRange(8, 1)];
    
    
    NSInteger tempTime =  [_minuteL.text integerValue] *60*10*1000 + [_minuteR.text integerValue] *60*1000 + [_secondL.text integerValue] *10 *1000 +  [_secondR.text integerValue]  *1000 +[_msecL.text integerValue] *100 + [_msecR.text integerValue] *10 +   [_msecS.text integerValue];
    
    self.submitBlock ? self.submitBlock(tempTime) : nil;
    
}







- (IBAction)submitButAction:(UIButton*)sender {
    
    sender.enabled = NO;
    
    [self.gcdTimer invalidate];
    
    
    [self performSelector:@selector(delayAction) withObject:nil afterDelay:0.0005];
}




//-(SNTimer *)gcdTimer {
//
//    if(!_gcdTimer){
//        __weak id weakSelf = self;
//        self.date1970 = [NSDate dateWithTimeIntervalSince1970:0];
//        _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:0.01 block:^{
//            [weakSelf updateTime];
//        }];
//
//    }
//    return _gcdTimer;
//}


- (NSDateFormatter *)dateFormatter {
    if(!_dateFormatter){
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"mm:ss:SSS"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
    }
    
    return _dateFormatter;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
