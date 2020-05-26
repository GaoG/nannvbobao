//
//  ViewController.m
//  NanNvBoBao
//
//  Created by  GaoGao on 2020/5/22.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ViewController.h"
#import "IpConfigView.h"
#import "CountDownView.h"
#import "StartView.h"
#import "SubmitView.h"
#import "NumberScrollView.h"
#import "ConfigHeader.h"
#import "ProgressView.h"
#import "TipsView.h"
#import "SecondViewController.h"
#import "WebSocketManager.h"

#import "GCDAsyncUdpSocket.h"


#define SERVERPORT 9600

@interface ViewController ()<WebSocketManagerDelegate,GCDAsyncUdpSocketDelegate>
@property (nonatomic, strong)UIView *scrollview;

@property (nonatomic, strong)IpConfigView *configView;

@property (nonatomic, strong)CountDownView *countDownView;

@property (nonatomic, strong)StartView *startView;

@property (nonatomic, strong)SubmitView *submitView;

@property (nonatomic, strong)TipsView *tipsView;


@property (nonatomic, strong)NumberScrollView *numberScrollView;

@property (nonatomic, strong)ProgressView *progressView;

@property (nonatomic, strong)NSMutableArray *viewArr;

@property (nonatomic, strong)WebSocketManager *webSocketManager;

@property (nonatomic, strong) NSData *address;


@end

@implementation ViewController{
    GCDAsyncUdpSocket *receiveSocket;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    
    return;
    
    [self initSocket];
    
    
    
    self.progressView.frame = self.view.bounds;
    [self.view addSubview:self.progressView];
    
    
    self.configView.frame = self.view.bounds;
    
    [self.view addSubview:self.configView];
    
    
    
    self.countDownView.frame = self.view.bounds;
    [self.view addSubview:self.countDownView];
    
    
    self.startView.frame = self.view.bounds;
    [self.view addSubview:self.startView];
    
    

    self.submitView.frame = self.view.bounds;
    [self.view addSubview:self.submitView];
    
    
    
    self.numberScrollView.frame = self.view.bounds;
    [self.view addSubview:self.numberScrollView];
    
    self.tipsView.frame = self.view.bounds;
    [self.view addSubview:self.tipsView];
    
    


    
    [self.viewArr addObjectsFromArray:@[self.configView,self.configView,self.countDownView,self.startView,self.submitView,self.numberScrollView,self.progressView,self.tipsView]];
    
    
    [self operateView:self.configView withState:NO];
}




- (void)initSocket {
    
    self.title = @"服务器";
    dispatch_queue_t dQueue = dispatch_queue_create("Server queue", NULL);
    receiveSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self
                                                  delegateQueue:dQueue];
    NSError *error;
    [receiveSocket bindToPort:SERVERPORT error:&error];
    if (error) {
        NSLog(@"服务器绑定失败");
    }
    [receiveSocket beginReceiving:nil];
}


- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    /**
     *  更新UI一定要到主线程去操作啊
     */
    dispatch_sync(dispatch_get_main_queue(), ^{
        
    });
    self.address = address;
    
//    NSString *sendStr = @"连接成功";

    [self sendGroupMessage:msg];
}



/// 像组中发送消息
-(void)sendGroupMessage:(NSString *)message {
    
    NSData *sendData = [message dataUsingEncoding:NSUTF8StringEncoding];
    [receiveSocket sendData:sendData toHost:[GCDAsyncUdpSocket hostFromAddress:self.address]
                       port:[GCDAsyncUdpSocket portFromAddress:self.address]
                withTimeout:60
                        tag:500];
    
    
}





-(void)ceshi:(BOOL)state withView:(UIView *)view {
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.duration=.0001;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat: state ? 3.1415926 : 0.0];
    [view.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
}




#pragma mark  websocekt 代理方法


- (void)webSocketDidReceiveMessage:(NSString *)string {
    
    if ([string isEqualToString:@"Success"]) {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:string message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }else{
        
        NSDictionary *result = [self dictionaryWithJsonString:string];
        NSDictionary *dataDic = result[@"data"];
        /// ProgramStart logo页 RollQuestion // 321 倒计时 数字滚动页
        // StartAnswer 开始提示页面
        NSString *stepName = dataDic[@"stepName"];
        
        
        if ([result [@"messageType"]intValue ] == 255) {
            /// 登陆成功
          UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
        } else if ([result [@"messageType"]intValue ] == 16 &&[stepName isEqualToString:@"ProgramStart"]){
            /// 首页
            [self operateView:self.startView withState:NO];
   
        }else if ([result [@"messageType"]intValue ] == 33){
            [self.webSocketManager sendDataToServerWithMessageType:@"255" data:@{@"code":@(16),@"message":@"block"}];
            
            /// 数字滚动
            NSDictionary *dataDic = result[@"data"];
            
            dataDic ? [self setRecollNumber:dataDic] :nil;
            

            
            
        }else if ([result [@"messageType"]intValue ] == 16 &&[stepName isEqualToString:@"StartAnswer"] ){
            // 开始页面tips
            
//            [self operateView:self.countDownView withState:NO];
//                        [self.countDownView countDownBegin:3];
            [self.webSocketManager sendDataToServerWithMessageType:@"255" data:@{@"code":@(16),@"message":@"scrollStart"}];
            [self operateView: self.tipsView withState:NO];
            self.tipsView.tipsLabel.titleLabel.text =@"开始";
        }else if ([result [@"messageType"]intValue ] == 16 &&[stepName isEqualToString:@"RollQuestion"] ){
            /// 开始倒计时  倒计时结束到 数字滚动页面
                    [self operateView:self.countDownView withState:NO];
                    [self.countDownView countDownBegin:3];
            
        }else if ([result [@"messageType"]intValue ] == 32 &&[dataDic[@"message"]isEqualToString:@"晋级成功"] ){
            /// 回到logo页面 晋级成功
            [self.tipsView.tipsLabel setTitle:@"晋级成功" forState:UIControlStateNormal];
            [self operateView: self.tipsView withState:NO];
            
            
            [self sendGroupMessage:@"20"];
            
            
        }else if ([result [@"messageType"]intValue ] == 32 &&[dataDic[@"message"]isEqualToString:@"晋级失败"] ){
            /// 回到logo页面 晋级失败
            [self.tipsView.tipsLabel setTitle:@"晋级失败" forState:UIControlStateNormal];
            [self operateView: self.tipsView withState:NO];
            
            
            [self sendGroupMessage:@"30"];
            
        }else if ([result [@"messageType"]intValue ] == 32 &&[dataDic[@"message"]isEqualToString:@"回答错误"] ){
            [self.tipsView.tipsLabel setTitle:@"回答错误" forState:UIControlStateNormal];
            /// 回到logo页面 晋级失败
            [self operateView: self.tipsView withState:NO];
            
                
        }
        
        
        
        
        
        
        
    }
    
    
    
}

#pragma mark 设置数字滚动的事件

-(void)setRecollNumber:(NSDictionary *)dic{
    
    NSArray *items = dic[@"dataItems"];
    /// 数字内容
    NSMutableArray *dataStringArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *selectStringArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *dic in items) {
        [selectStringArr addObject:dic[@"SelectedItemString"]];
        [dataStringArr addObject:dic[@"DataString"]];
    }
    self.numberScrollView.selectedStringArr = selectStringArr;
    
    self.numberScrollView.dataArr = dataStringArr;
    
//    [self operateView:self.numberScrollView withState:NO];
//
//    [self.numberScrollView scrollWithSpace:1];
    
}


#pragma mark  隐藏或显示某个view

-(void)operateView:(UIView *)view withState:(BOOL)state {
    
    for (UIView *sub in self.viewArr) {
        
        if (sub == view) {
            sub.hidden = state;
        }else{
           sub.hidden = !state;
        }
        
    }
}



-(IpConfigView *)configView {
    
    
    if (!_configView) {
        _configView = [[[NSBundle mainBundle]loadNibNamed:@"IpConfigView" owner:nil options:nil]lastObject];
        
        @weakify(self)
        _configView.connectBlock = ^(NSString * _Nonnull mainIP, NSString * _Nonnull ID, NSString * _Nonnull listIP, NSString * _Nonnull audienceIP, NSInteger type) {
            @strongify(self)
            
            if( type == 1){
            [self.webSocketManager testConnectServerWithIp:mainIP withdeviceID:ID];
            }else if (type ==2){
                NSDictionary * data = @{@"deviceId":[NSString stringWithFormat:@"%@",ID],@"deviceInfo":ID };
                [self.webSocketManager sendDataToServerWithMessageType:@"0" data:data];
            }
        };
        
    }
    
    
    return _configView;
}


-(CountDownView *)countDownView {
    
    if (!_countDownView) {
        _countDownView = [[[NSBundle mainBundle]loadNibNamed:@"CountDownView" owner:nil options:nil]lastObject];
        @weakify(self)
        _countDownView.endBlock = ^{
          @strongify(self)
            [self operateView:self.numberScrollView withState:NO];
            
            [self.numberScrollView scrollWithSpace:1.5];
        };
        
    }
    
    
    return _countDownView;
}



-(StartView *)startView {
    
    if (!_startView) {
        _startView = [[[NSBundle mainBundle]loadNibNamed:@"StartView" owner:nil options:nil]lastObject];
    }
    
    
    return _startView;
}



-(SubmitView *)submitView {
    
    if (!_submitView) {
        _submitView = [[[NSBundle mainBundle]loadNibNamed:@"SubmitView" owner:nil options:nil]lastObject];
        @weakify(self)
        _submitView.submitBlock = ^{
            @strongify(self)
            [self sendGroupMessage:@"10"];
            
        };
    }
    
    
    return _submitView;
}

-(NumberScrollView *)numberScrollView {
    
    if (!_numberScrollView) {
        _numberScrollView = [[[NSBundle mainBundle]loadNibNamed:@"NumberScrollView" owner:nil options:nil]lastObject];
         @weakify(self)
        _numberScrollView.scrollEndBlock = ^{
          @strongify(self)
            [self operateView:self.submitView withState:NO];
            [self.submitView start];
        };
    }
    
    return _numberScrollView;
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

-(WebSocketManager *)webSocketManager {
    
    if (!_webSocketManager) {
        _webSocketManager = [WebSocketManager shared];
        _webSocketManager.delegate = self;
    }
    
    return _webSocketManager;
}

-(TipsView *)tipsView {
    
    if (!_tipsView) {
        _tipsView = [[[NSBundle mainBundle]loadNibNamed:@"TipsView" owner:nil options:nil]lastObject];
        
    }
    
    return _tipsView;
}




//// 字符串转字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
