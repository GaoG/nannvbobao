//
//  SecondViewController.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "SecondViewController.h"
#import "StartView.h"
#import "ShowNumberView.h"
#import "ProgressView.h"
#import "StartView.h"
#import "SubmitView.h"
@interface SecondViewController ()

@property (nonatomic, strong) StartView *startView;

@property (nonatomic, strong) ShowNumberView *showNumberView;

@property (nonatomic, strong)ProgressView *progressView;


@property (nonatomic, strong)SubmitView *submitView;

@property (nonatomic, strong)NSMutableArray *viewArr;


@end

@implementation SecondViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startView.frame = self.view.bounds;
    [self.view addSubview:self.startView];
    
    self.showNumberView.frame = self.view.bounds;
    [self.view addSubview:self.showNumberView];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    static int a = 0;
    
    a++;
    
    
    [self.showNumberView setText:[NSString stringWithFormat:@"%010ld",arc4random() % 10000000000000] andColor:2];
    
    
    
}


-(StartView *)startView {
    
    if (!_startView) {
        _startView = [[[NSBundle mainBundle]loadNibNamed:@"StartView" owner:nil options:nil]lastObject];
    }
    
    
    return _startView;
}


-(ShowNumberView *)showNumberView {
    
    if (!_showNumberView) {
        _showNumberView = [[[NSBundle mainBundle]loadNibNamed:@"ShowNumberView" owner:nil options:nil]lastObject];
    }
    
    
    return _showNumberView;
}




-(SubmitView *)submitView {
    
    if (!_submitView) {
        _submitView = [[[NSBundle mainBundle]loadNibNamed:@"SubmitView" owner:nil options:nil]lastObject];
        
    }
    
    
    return _submitView;
}




-(ProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[[NSBundle mainBundle]loadNibNamed:@"ProgressView" owner:nil options:nil]lastObject];
        
    }
    
    return _progressView;
}

-(NSMutableArray *)viewArr{
    
    if (!_viewArr) {
        _viewArr = [NSMutableArray array];
    }
    return _viewArr;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
