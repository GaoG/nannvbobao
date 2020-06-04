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
#import "WebSocketManagerA.h"
#import "GCDAsyncUdpSocket.h"


#define SERVERPORT 9600

@interface ViewController ()<WebSocketManagerDelegate,GCDAsyncUdpSocketDelegate,WebSocketManagerDelegateA>
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

@property (nonatomic, strong)WebSocketManagerA *webSocketManagerA;

@property (nonatomic, strong) NSData *address;

@property (nonatomic, assign) float space;

@property (nonatomic, assign) float time;

@property (nonatomic, copy) NSString * myID;

@property (nonatomic, assign) BOOL isFail;

@end

@implementation ViewController{
    GCDAsyncUdpSocket *receiveSocket;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    //    [self.submitView start];
    
    
    
    self.numberScrollView.frame = self.view.bounds;
    [self.view addSubview:self.numberScrollView];
    
    self.tipsView.frame = self.view.bounds;
    [self.view addSubview:self.tipsView];
    
    
    
    
    [self.viewArr addObjectsFromArray:@[self.configView,self.configView,self.countDownView,self.startView,self.submitView,self.numberScrollView,self.progressView,self.tipsView]];
    
    
    [self operateView:self.configView withState:NO];
}




- (void)initSocket {
    
    
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


-(void)webSocketDidConnect:(BOOL)state{
    
    [self operateView:self.startView withState:NO];
    
}



- (void)webSocketDidReceiveMessage:(NSString *)string {
    
    
    NSDictionary *dic = [self dictionaryWithJsonString:string];
    
    NSString *tempID = [NSString stringWithFormat:@"%@",dic[@"id"]];
///    200 下一轮 判断是否晋级 
    
    /// 首页
    if ([tempID isEqualToString:@"200"]) {
        
        [self operateView:self.startView withState:NO];
        
        if(!self.isFail){
            
            /// 法观众端 观众端
            [self sendGroupMessage:@"50"];
        }
        
    }else if ([tempID isEqualToString:@"106"]&&!self.isFail) {
        /// /显示开始
        [self.tipsView tipsAction:1];
        [self operateView:self.tipsView withState:NO];
        
    }else if ([tempID isEqualToString:@"105"]&&!self.isFail){
        //点击开始
        [self operateView:self.countDownView withState:NO];
        [self.countDownView countDownBegin:3];
        
    }else if ([tempID isEqualToString:@"110"]&&!self.isFail){
        //倒计时 抢答
        [self operateView:self.submitView withState:NO];
        [self.submitView start];
//        [self.countDownView countDownBegin:3];
        
    }else if ([tempID isEqualToString:@"108"]){
        /// 复位
        [self operateView:self.startView withState:NO];
        [self sendGroupMessage:@"50"];
        self.isFail = NO;
        
    }else if ([tempID isEqualToString:@"107"]&&!self.isFail){
        /// 结果
        ///result 1正确 0 错误 2晋级
        NSInteger  result = [dic[@"result"] integerValue];
        
        /// 判断当前id 是否和自己的id相同
        NSString *numberId = [NSString stringWithFormat:@"%@",dic[@"number"]] ;
        
        if(![numberId isEqualToString:self.myID]){
            return;
        }
        if (result ==1 ) {
            //            //            tips = @"正确";
            //            [self.tipsView answerAction:1];
            //
            //            [self operateView: self.tipsView withState:NO];
            //
            //            [self sendGroupMessage:@"40"];
            //            self.isFail = YES;
            
        }else if (result ==0){
            //            tips = @"错误";
            
            [self.tipsView answerAction:2];
            [self operateView: self.tipsView withState:NO];
            self.isFail = YES;
            [self sendGroupMessage:@"30"];
            
        }else if (result ==2){
            //            tips = @"晋级";
            
            [self.tipsView answerAction:1];
            [self operateView: self.tipsView withState:NO];
            self.isFail = YES;
            [self sendGroupMessage:@"20"];
        }
        
   
    }
    
    
    
    
    
    
    
    return;
    
   
    
}

#pragma mark 设置数字滚动的事件

-(void)setRecollNumber:(NSDictionary *)dic{
    
    NSArray *items = dic[@"dataItems"];
    /// 数字内容
    NSMutableArray *dataStringArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *selectStringArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *dic in items) {
        [selectStringArr addObject:dic[@"SelectedItemIndex"]];
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
        _configView.connectBlock = ^(NSString *ID,NSString *mainIP,NSString *listIP,NSString *audienceIP, NSInteger type) {
            @strongify(self)
            
//            if( type == 1){
            
                [self.webSocketManager testConnectServerWithIp:mainIP withdeviceID:ID];
                self.myID = ID;
            
                [self.webSocketManagerA testConnectServerWithIp:listIP withdeviceID:ID];
            
                
//            }else if (type ==2){
//                NSDictionary * data = @{@"deviceId":[NSString stringWithFormat:@"%@",ID],@"deviceInfo":ID };
//                [self.webSocketManager sendDataToServerWithMessageType:@"0" data:data];
//                self.myID = ID;
//            }
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
            [self operateView:self.startView withState:NO];
//            [self.submitView start];
            
//            [self operateView:self.numberScrollView withState:NO];
//            [self.numberScrollView scrollWithSpace:self.space andAnmintTime:self.time];
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
        _submitView.submitBlock = ^(NSInteger time) {
            @strongify(self)
            [self sendGroupMessage:@"10"];
            time = time <=0 ? 1:time;
            
            NSDictionary *data = @{
                                   @"id":@(100),
                                   @"number":[NSNumber numberWithInteger:[self.myID integerValue]],
                                   @"useTime":@(time),
                                   @"projectID":@(1)
                                   };
            
            [self.webSocketManagerA sendDataToServerWithMessageType:@"0" data:data];
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


-(WebSocketManagerA *)webSocketManagerA {
    
    if (!_webSocketManagerA) {
        _webSocketManagerA = [WebSocketManagerA shared];
        _webSocketManagerA.delegate = self;
    }
    
    return _webSocketManagerA;
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

