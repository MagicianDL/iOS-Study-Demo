//
//  ViewController.m
//  C_Version_Socket_Server
//
//  Created by Dalang on 16/5/24.
//  Copyright © 2016年 Dalang. All rights reserved.
//

#import "ViewController.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
//    [self TCPServer];
    [self UDPServer];
    
    
}

// MARK: TCP
- (void)TCPServer
{
    // 1.创建socket
    int error = -1;
    // 创建socket套接字
    int serverSocketId = socket(AF_INET, SOCK_STREAM, 0);
    BOOL success = (serverSocketId != -1);
    
    // 2.如果创建成功，绑定端口
    if (success) {
        // Socket address
        struct sockaddr_in addr;
        // 初始化全置为0
        memset(&addr, 0, sizeof(addr));
        // 制定socket地址长度
        addr.sin_len = sizeof(addr);
        // 指定网络协议，这里使用的是TCP/UDP则指定为AF_INET
        addr.sin_family = AF_INET;
        // 指定端口号
        addr.sin_port = htons(1024);
        // 指定监听的ip，指定为INADDR_ANY时，表示监听所有ip
        addr.sin_addr.s_addr = INADDR_ANY;
        // 绑定套接字
        error = bind(serverSocketId, (const struct sockaddr *)&addr, sizeof(addr));
        success = (error == 0);
    }
    // 3.监听
    if (success) {
        NSLog(@"server TCP socket bind success");
        error = listen(serverSocketId, 5);
        success = (error == 0);
    }
    
    if (success) {
        NSLog(@"server TCP socket listen success");
        while (true) {
            // p2p
            struct sockaddr_in peerAddr;
            int peerSocketId;
            socklen_t addrLen = sizeof(peerAddr);
            
            // 4.等待客户端连接
            // 服务器端等待从编号为serverSocketId的Socket接收客户端请求
            peerSocketId = accept(serverSocketId, (struct sockaddr *)&peerAddr, &addrLen);
            success = (peerSocketId != -1);
            if (success) {
                NSLog(@"server TCP socket accept success, remote address: %s, port: %d", inet_ntoa(peerAddr.sin_addr), ntohs(peerAddr.sin_port));
                char buf[1024];
                size_t len = sizeof(buf);
                
                // 5.接收来自客户端的信息
                // 当客户端进入exit的时候才退出
                do {
                    recv(peerSocketId, buf, len, 0);
                    if (strlen(buf) != 0) {
                        NSString *string = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
                        NSLog(@"server TCP socket received message from client:\n %@", string);;
                    }
                } while (strcmp(buf, "exit") != 0);
                NSLog(@"server TCP socket 收到exit信号，本次socket通信完毕");
                
                // 6. 关闭socket
                close(peerSocketId);
            }
        }
    }
}

// MARK: UDP
- (void)UDPServer
{
    int serverSocketId = -1;
    ssize_t len = -1;
    socklen_t addrLen;
    char buff[1024];
    struct sockaddr_in ser_addr;
    
    // 1. 创建socket
    // 注意：第二个参数是SOCK_DGRAM，因为UDP是数据报格式的
    serverSocketId = socket(AF_INET, SOCK_DGRAM, 0);
    if (serverSocketId < 0) {
        NSLog(@"create server UDP socket fail.");
        return;
    }
    addrLen = sizeof(struct sockaddr_in);
    bzero(&ser_addr, addrLen);
    
    ser_addr.sin_family = AF_INET;
    ser_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    ser_addr.sin_port = htons(1024);
    
    // 2.绑定端口
    int success = bind(serverSocketId, (const struct sockaddr *)&ser_addr, addrLen);
    if (success < 0) {
        NSLog(@"server UDP socket connect fail.");
        return;
    }
    
    do {
        bzero(buff, sizeof(buff));
        
        // 3. 接收客户端的消息
        len = recvfrom(serverSocketId, buff, sizeof(buff), 0, (struct sockaddr *)&ser_addr, &addrLen);
        // 显示client端的网络地址
        NSLog(@"receive from %s\n", inet_ntoa(ser_addr.sin_addr));
        // 显示客户端发来的字符串
        NSLog(@"recevce:%s", buff);
        
        // 4.将收到的客户端发送的消息，发回客户端
        sendto(serverSocketId, buff, len, 0, (const struct sockaddr *)&ser_addr, addrLen);
        
    } while (strcmp(buff, "exit") != 0);
    
    // 5.关闭socket
    close(serverSocketId);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
