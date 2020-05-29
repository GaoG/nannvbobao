//
//  WebSocketManagerA.h
//  iosWebSocket
//
//  Created by 郑士峰 on 2020/5/27.
//  Copyright © 2020 yanglele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WebSocketStatusA){
    WebSocketStatusADefault = 0, //初始状态，未连接
    WebSocketStatusAConnect,     //已连接
    WebSocketStatusADisConnect,  //断开连接
};

@protocol WebSocketManagerDelegateA<NSObject>

-(void)webSocketDidReceiveMessageA:(NSString *)string;

@end


@interface WebSocketManagerA : NSObject

@property(nonatomic, strong) SRWebSocket *webScoket;
@property(nonatomic, weak) id<WebSocketManagerDelegateA> delegate;
@property(nonatomic, assign) BOOL isConnect; //是否连接
@property(nonatomic, assign) WebSocketStatusA socketStatus;

@property(nonatomic, copy) NSString * myIP;

@property(nonatomic, copy) NSString * myID;

+(instancetype)shared;
-(void)connectServer;//建立长连接
-(void)reConnectServer;//重新连接
-(void)webSocketClose;//关闭连接
-(void)sendDataToServer:(NSString *)data; //向服务器发送数据
-(void)sendDataToServerWithMessageType:(NSString *)messageType data:(NSDictionary *)data;//向服务器发送数据


///建立长连接 ip
-(void)testConnectServerWithIp:(NSString *)ip withdeviceID:(NSString *)ID;


@end

NS_ASSUME_NONNULL_END
