//
//  CountDownView.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "CountDownView.h"
@interface CountDownView ()

@property (nonatomic,strong) id timer;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *countdownImageView;

@property (nonatomic,strong) NSArray *imageArr;


@end

@implementation CountDownView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    
    return self;
}



/// 倒计时开始
-(void)countDownBegin:(NSInteger)tempSecond {
    
 
//    __block NSInteger second = tempSecond == 0 ? 3 :tempSecond ;
    __block NSInteger second = 4;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    
    _timer = timer;
    __weak id weakSelf = self;
    
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 2, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second > 1) {
//                weakSelf.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)second];
                second --;
                self.countdownImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"countdown_%ld",(long)second]];
                
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                self.endBlock ? self.endBlock() : nil;
            }
        });
    });
    //启动源
    dispatch_resume(_timer);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
