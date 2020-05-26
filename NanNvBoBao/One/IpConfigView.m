//
//  IpConfigView.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "IpConfigView.h"

@interface IpConfigView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *deviceID;
@property (weak, nonatomic) IBOutlet UITextField *mainIP;


@property (weak, nonatomic) IBOutlet UITextField *listIP;

@property (weak, nonatomic) IBOutlet UITextField *audienceIP;


@property (weak, nonatomic) IBOutlet UIButton *submitBut;
@property (weak, nonatomic) IBOutlet UIButton *testBut;


@end
@implementation IpConfigView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
    self.deviceID.delegate = self;
    self.mainIP.delegate = self;
    self.listIP.delegate = self;
    self.audienceIP.delegate = self;
    
    
}


- (IBAction)submitAction:(id)sender {
    
    [self endEditing:YES];
    
    [self connectAction:1];
    
    
}



- (IBAction)testAction:(id)sender {
    [self endEditing:YES];
    
    [self connectAction:2];
    
    
}

/// type 1提交  2测试
-(void)connectAction:(NSInteger)type {
    
//    id
    NSString *IDStr = [self.deviceID.text stringByReplacingOccurrencesOfString:@" " withString:@""] ;
//    ip
    NSString *mainIPStr = [self.mainIP.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    排行版
    NSString *listIPStr = [self.listIP.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//   观众
    NSString *audienceIPStr = [self.audienceIP.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.connectBlock ? self.connectBlock(IDStr, mainIPStr, listIPStr, audienceIPStr, type) : nil;
  
}


#pragma mark  代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self endEditing:YES];
    return YES;
};



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
    
    
}


@end
