#CFSocket Reference

一个`CFSocket`就是一个BSD Socket实现的通信信道。

对于这个API的大多数使用，你将需要引入三个头文件：

```
#import <CoreFoundation/CoreFoundation.h>  
#include <sys/socket.h>  
#include <netinet/in.h>
```

`CFSocket`可以通过`CFSocketCreate`和`CFSocketCreateWithSocketSignature`从头开始创建。`CFSocket`对象也可以通过调用`CFSocketCreateWithNative`包含现有的BSD socket来创建。最后，你可以通过调用`CFSocketCreateConnectedToSocketSignature`创建一个`CFSocket`并且连接到远程主机。

对于监听消息，你需要通过`CFSocketCreateRunLoopSource`创建一个运行循环源（Runloop source）并且调用`CFRunLoopAddSource`将它添加到一个运行循环（Run loop）中。你可以选择socket活动的类型，例如连接尝试或者数据到达（data arrivals）,它将使源（source）启动和调用你的`CFSocket`的回调函数。对于发送数据，将数据存储字`CFData`中并且调用`CFSocketSendData`。

与Mach和消息端口不同，socket提供网络上的通信。

##函数

###创建socket
`CFSocketCreate`

####创建一个指定协议和类型的`CFSocket`对象

####声明

`CFSocketRef CFSocketCreate ( CFAllocatorRef allocator, SInt32 protocolFamily, SInt32 socketType, SInt32 protocol, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context );`

####参数

参数 | 描述 
------------ | ------------- 
`allocator` | `allocator`用于分配内存给新对象。传入`NULL`或者`kCFAllocatorDefault`来使用当前的默认的allocator。 
`protocolFamily` | socket的协议族。如果传入负数或0，socket默认为`PF_INET`。
`socketType` | 要创建的socket类型。如果`protocolFamily`是`PF_INET`并且`socketType`是负数或0，socket的类型默认为`SOCKET_STREAM`。
`callBackTypes` | 一个按位或（bitwise-OR）组合类型的socket活动，用该造成`callout`的调用。查看`Callback Types`来了解可能的活动值。
`callout` | 当一个通过`callBackTypes`指示的活动发生时调用的函数。
`context` | 一个为`CFSocket`对象保持上下文信息的结构体。函数从结构体中复制出信息，所以上下文指向的内存不需要在超出函数调用之后保留。可以是`NULL`。

####返回值

新的`CFSocket`对象或者`NULL`（如果一个错误发生）。所有权遵循`Create Rule`。

####可用性 

iOS 2.0之后可用。

----

`CFSocketCreateConnectedToSocketSignature`

创建一个`CFSocket`对象并对一个远程socket开启连接。

####声明

`CFSocketRef CFSocketCreateConnectedToSocketSignature ( CFAllocatorRef allocator, const CFSocketSignature *signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context, CFTimeInterval timeout );`

####参数
参数 | 描述 
------------ | ------------- 
`allocator` | `allocator`用于分配内存给新对象。传入`NULL`或者`kCFAllocatorDefault`来使用当前的默认的allocator。 
`signature` | 一个`CFSocketSignature`识别`CFSocket`对象应该连接的协议和地址。
`callBackTypes` | 一个按位或（bitwise-OR）组合类型的socket活动，用该造成`callout`的调用。查看`Callback Types`来了解可能的活动值。
`callout` | 当一个通过`callBackTypes`指示的活动发生时调用的函数。
`context` | 一个为`CFSocket`对象保持上下文信息的结构体。函数从结构体中复制出信息，所以上下文指向的内存不需要在超出函数调用之后保留。可以是`NULL`。
`timeout` | 等待一个连接成功的超时时间。如果使用一个负值，这个函数不会等待连接，而是尝试让连接在后台发生。如果`callBackTypes`包含`kCFSocketConnectCallBack`，当后台连接成功或失败的时候你会收到一个回调。

####返回值

新的`CFSocket`对象或者`NULL`（如果一个错误发生）。所有权遵循`Create Rule`。

####可用性 

iOS 2.0之后可用。

----

`CFSocketCreateWithNative`

通过一个已经存在的本地socket创建一个`CFSocket`对象。

####声明
`CFSocketRef CFSocketCreateWithNative ( CFAllocatorRef allocator, CFSocketNativeHandle sock, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context );`

####参数
参数 | 描述 
------------ | ------------- 
`allocator` | `allocator`用于分配内存给新对象。传入`NULL`或者`kCFAllocatorDefault`来使用当前的默认的allocator。 
`sock` | 用来创建`CFSocket`对象的本地socket。
`callBackTypes` | 一个按位或（bitwise-OR）组合类型的socket活动，用该造成`callout`的调用。查看`Callback Types`来了解可能的活动值。
`callout` | 当一个通过`callBackTypes`指示的活动发生时调用的函数。
`context` | 一个为`CFSocket`对象保持上下文信息的结构体。函数从结构体中复制出信息，所以上下文指向的内存不需要在超出函数调用之后保留。可以是`NULL`。

####返回值
新的`CFSocket`对象或者`NULL`（如果一个错误发生）。如果针对`sock`的`CFSocket`对象已经存在，这个函数热安徽已经存在的对象来代替创建一个新的对象。`context`，`callout`和`callBackTypes`参数将在这种情况下忽略。所有权遵循`Create Rule`。

####可用性 

iOS 2.0之后可用。

----

`CFSocketCreateWithSocketSignature`
使用`CFSocketSignature`结构体中的信息创建一个`CFSocket`对象。

####声明
`CFSocketRef CFSocketCreateWithSocketSignature ( CFAllocatorRef allocator, const CFSocketSignature *signature, CFOptionFlags callBackTypes, CFSocketCallBack callout, const CFSocketContext *context );`

####参数

参数 | 描述 
------------ | ------------- 
`allocator` | `allocator`用于分配内存给新对象。传入`NULL`或者`kCFAllocatorDefault`来使用当前的默认的allocator。 
`signature` | 一个`CFSocketSignature`识别通信协议和地址，来创建`CFSocket`对象。
`callBackTypes` | 一个按位或（bitwise-OR）组合类型的socket活动，应该造成`callout`的调用。查看`CallbackTypes`来了解可能的活动值。
`callout` | 当一个通过`callBackTypes`指示的活动发生时调用的函数。
`context` | 一个为`CFSocket`对象保持上下文信息的结构体。函数从结构体中复制出信息，所以上下文指向的内存不需要在超出函数调用之后保留。可以是`NULL`。

####返回值

新的`CFSocket`对象或者`NULL`（如果一个错误发生）。所有权遵循`Create Rule`。

####可用性 

iOS 2.0之后可用。


###配置socket

`CFSocketCopyAddress`

返回一个`CFSocket`对象的本地地址。

####声明

`CFDataRef CFSocketCopyAddress ( CFSocketRef s );`

####参数
参数 | 描述 
------------ | ------------- 
`s` | 被审核的`CFSocket`对象。

####返回值
`s`连接的本地地址，将协议族（例如`struct sockaddr_in`或`struct sockaddr_in6`）作为一个适当的`struct sockaddr`存储在一个`CFData`对象中。所有权遵循`Create Rule`。

 
####可用性 

iOS 2.0之后可用。

----

`CFSocketCopyPeerAddress`

返回`CFSocket`对象连接的远程地址。

####声明
`CFDataRef CFSocketCopyPeerAddress ( CFSocketRef s );`

####参数
参数 | 描述 
------------ | ------------- 
`s` | 被审核的`CFSocket`对象。

####返回值
`s`连接的远程地址，将协议族（例如`struct sockaddr_in`或`struct sockaddr_in6`）作为一个适当的`struct sockaddr`存储在一个`CFData`对象中。所有权遵循`Create Rule`。

####可用性 

iOS 2.0之后可用。

----

`CFSocketDisableCallBacks`
对某些类型的socket活动禁止`CFSocket`对象的回调函数。

####声明
`void CFSocketDisableCallBacks ( CFSocketRef s, CFOptionFlags callBackTypes );`

####参数

参数 | 描述
------------ | ------------
`s` | 将要修改的`CFSocket`对象。
`callBackTypes` | 一个按位或（bitwise-OR）的`CFSocket`对象活动的组合，不会造成`s`的回调函数被调用。查看`CallbackTypes`来了解可能的活动值。

####讨论
当你创建`s`的时候，如果不在想要请求某些回调，你可以使用这个函数暂时禁用这些回调。使用`CFSocketEnableCallBacks`来重新启用一个回调函数。

####可用性
iOS 2.0之后可用

----

`CFSocketEnableCallBacks`
对于某些活动类型的socket活动，启用`CFSocket`对象的回调函数。

####声明
`void CFSocketEnableCallBacks ( CFSocketRef s, CFOptionFlags callBackTypes );`

####参数

参数 | 描述
--- | ---
`s` | 将要修改的`CFSocket`对象。
`callBackTypes` | 一个按位或（bitwise-OR）的CFSocket对象活动的组合，应该造成`s`的回调函数被调用。查看`CallbackTypes`来了解可能的活动值。

####讨论
如果一个回调类型不会自动启用，亦可以使用这个函数启用这个回调（一次）。

这次调用不会影响在未来这个回调类型将要自动重新启用。如果你想设置一个回调类型自动被重新启用，使用`CFSocketSetSocketFlags`。

当创建`CFSocket`对象的时候，务必确定你的`CFSocket`对象实际上具有并且已经请求启用一个回调类型。启用其他回调类型的结果是不确定的。

####可用性
iOS 2.0或2.0之后可用。

----

`CFSocketGetContext`
返回一个`CFSocket`对象的上下文信息。

####声明

`void CFSocketGetContext ( CFSocketRef s, CFSocketContext *context );`

####参数

参数 | 描述
--- | ---
`s` | 被审核的`CFSocket`对象。
`context` | 一个指向复制于`s`上下文信息的结构体。返回的信息通畅和你创建`CFSocket`对象时传入 `CFSocketCreate`, `CFSocketCreateConnectedToSocketSignature`, `CFSocketCreateWithNative`或`CFSocketCreateWithSocketSignature`的信息相同。然而，如果`CFSocketCreateWithNative`返回一个缓存的`CFSocket`对象而不是创建一个新的对象，`context`中填充的是原来的`CFSocket`对象的信息而不是你传入这个函数的信息。

####讨论

`CFSocket`的上下文版本号当前是0。在调用这个函数之前，你需要初始化`context`的版本还为0.

####可用性
iOS 2.0或2.0之后可用。

----

`
CFSocketGetNative`
返回一个关联本地socket的`CFSocket`对象。

####声明
`CFSocketNativeHandle CFSocketGetNative ( CFSocketRef s );`

####参数

参数 | 描述
--- | ---
`s` | 被审核的`CFSocket`对象。

####返回值
关联本地socket的`s`，如果`s`失效了，返回 -1， `INVALID_SOCKET`。

####可用性
iOS 2.0或2.0之后可用。

----

`CFSocketGetSocketFlags`
返回控制`CFSocket`对象某些行为的标志。

####声明
`CFOptionFlags CFSocketGetSocketFlags ( CFSocketRef s );`

####参数
参数 | 描述
--- | ---
`s` | 被审核的`CFSocket`对象。

####返回值
一个控制`s`行为的按位或的标识组合。查看`CFSocket Flags`来获取可用的标识列表。

####讨论
查看`CFSocketSetSocketFlages`来了解一个`CFSocket`的标识所代表的详细细节。

####可用性
iOS 2.0或2.0之后可用。

----

`CFSocketSetAddress`
绑定一个本地地址到`CFSocket`对象并且配置它来监听。

####声明
`CFSocketError CFSocketSetAddress ( CFSocketRef s, CFDataRef address );`

####参数
参数 | 描述
--- | ---
`s` | 将要修改的`CFSocket`对象。
`address` | 一个包含`s`协议族（例如`struct sockaddr_in` 或 `struct sockaddr_in6`）的`struct sockaddr`的`CFData`对象。这个对象仅用于这个函数调用的这段时间。

####返回值
一个指示成功或失败的错误编码。

####讨论
这个函数通过调用`bind`来绑定socket，并且如果socket支持，通过调用`listen`（with a backlog of 256）来配置socket监听。

一旦`s`被绑定`address`，其他的进程和电脑就能连接`s`，这取决于socket的协议。

####可用性
iOS 2.0或2.0之后可用。

----

`CFSocketSetSocketFlags`
设置控制一个`CFSocket`对象的某些行为的标识

####声明
`void CFSocketSetSocketFlags ( CFSocketRef s, CFOptionFlags flags );`

####参数
参数 | 参数
--- | ---
`s` | 将要被修改的`CFSocket`对相。
`flags` | 一个按位或的控制`s`行为的标志集合。查看`CFSocket Flags`来了解可用的标志列表。

####讨论
`flags`参数控制是否一个指定类型的回调触发之后自动重新启用，是否当`s`失效之后底层的本地socket被关闭。

要设置和清除标志，你必须在标志设置中分别设置和掩藏码位。首先，调用` CFSocketGetSocketFlags`，然后修改返回值。例如

```

 	CFOptionFlags sockopt = CFSocketGetSocketFlags (mysock );
 
     /* Set the read callback to be automatically reenabled. */
    sockopt |= kCFSocketAutomaticallyReenableReadCallBack;
 
    /* Clear the close-on-invalidate flag. */
    sockopt &= ~kCFSocketCloseOnInvalidate;
 
    CFSocketSetSocketFlags(s, sockopt);
    
```

默认情况下，当他们被触发之后，`kCFSocketReadCallBack`, `kCFSocketAcceptCallBack`和`kCFSocketDataCallBack` 回调会自动重新启用，而`kCFSocketWriteCallBack`回调没有；`kCFSocketConnectCallBack`回调只能发生一次，所以它们不能被重新启用。

如果回调自动重新启用，它每次调用条件都变成`true`。例如，一个读取回调被调用和socket上的数据等待被读取时间一样长。如果一个回调没有自动重新启用，然后它被调用一次，并且不会再次调用，直到你手动调用`CFSocketEnableCallBacks`重新启用。

关于自动启用读取和写入回调要小心。如果你要这样做，只要socket仍然可读可写，回调就会分别被调用。

确定只能对实际上有回调类型的`CFSocket`对象设置这些标志。对其它回调类型设置它们的结果是未定义的。

默认情况下当`s`失效的时候底层的本地socket被关闭。清空`kCFSocketCloseOnInvalidate`标志来禁止它。当你想要销毁一个`CFSocket`对象然而却想继续使用底层的本地socket，它将变得很实用。当你不需要它的时候，`CFSocket`对象必须取消。

当你没有取消`CFSocket`对象的时候，不要关闭底层的本地socket。

####可用性
iOS 2.0或2.0之后可用。


###使用Socket

`CFSocketConnectToAddress` 
对一个远程socket开启连接。

####声明
`CFSocketError CFSocketConnectToAddress ( CFSocketRef s, CFDataRef address, CFTimeInterval timeout );`

####参数

参数 | 描述
--- | ---
`s` | 带有连接`address`的`CFSocket`对象
`address` | `s`协议族（例如，`struct sockaddr_in`和`struct sockaddr_in6`）的包含一个适当的`struct sockadd_in6`的`CFData`对象。
`timeout` | 连接成功需要等待的超时时间。如果使用一个负值，这个函数不会等待连接，而是尝试使连接在后台发生。如果`s`请求一个`kCFSocketConnectCallBack`，当后台连接成功或失败的时候你会收到一个回调。

####返回值
一个尝试连接的指示成功或失败的错误码。

####可用性
iOS 2.0 或2.0之后可用。

----

`CFSocketCreateRunLoopSource`
为`CFSocket`对象创建`CFRunLoopSource`对象

####声明
`CFRunLoopSourceRef CFSocketCreateRunLoopSource ( CFAllocatorRef allocator, CFSocketRef s, CFIndex order );`

####参数
参数 | 描述
--- | ---
`allocator` | `allocator`用于为新的对象申请开辟内存。传入`NULL`或`kCFAllocatorDefault`来使用当前默认的`allocator`。
`s` | 创建运行循环源的`CFSocket`对象。
`order` | 一个指示处理运行循环源顺序优先级索引。当多个运行循环源在一个单一的运行循环中启动穿过的时候，源通过这个参数的进行升序处理。如果每个运行循环在每次循环中只处理一个源，只有最高优先级的源，具有最低`order`值的源被处理。

####返回值
`s`的一个新的`CFRunLoopSource`对象。所有权遵循`Create Rule`。

####讨论
运行循环源不会自动加入到一个运行循环中。想要将源加入到一个运行循环中，使用`CFRunloopAddSource`。

####可用性
iOS 2.0 和2.0之后可用。

----

`CFSocketGetTypeID`
返回`CFSocket`不透明类型的类型标识。

####声明
`CFTypeID CFSocketGetTypeID ( void )`

####返回值
`CFSocket`不透明类型的类型标识。

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketInvalidate`
使一个`CFSocket`对象失效，终止它发送或接受任何更多的消息。

####声明
`void CFSocketInvalidate( CFSocketRef s )`

####参数
参数 | 描述
--- | ---
`s` | 要失效的`CFSocekt`对象。

####讨论
当你使用一个socket对象的时候你应该总是使它失效。使`CFSocket`对象失效来防止它接收或发出任何多余的消息，但是不要释放socket对象本身。

如果为`s`创建一个运行循环源，运行循环源失效。

如果`CFSocketContext`对象指定一个释放的回调，这个函数在`info`领域（`s`创建时提供的）调用它来释放这个对象。

默认情况下，这个调用关闭了底层的socket。如果你已经通过调用`CFSocketSetSocketFlags`明确清空了` kCFSocketCloseOnInvalidate`标识，在调用这个函数知乎你必须手动关闭这个socket。

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketIsValid`
返回一个布尔值来指示是否一个`CFSocket`对象是有效的并且能够发送或接收消息

####声明
`Boolean CFSocketIsValid ( CFSocketRef s );`

####参数

参数 | 描述
--- | ---
`s` | 被审核的`CFSocket`对象。

####返回值
如果`s`可用于通信则返回`true`，否则返回`false`。

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketSendData`
在`CFSocket`上发送数据.

####声明
`CFSocketError CFSocketSendData ( CFSocketRef s, CFDataRef address, CFDataRef data, CFTimeInterval timeout );`

####参数
参数 | 描述
--- | ---
`s` | 使用的`CFSocket`对象。
`address` | `data`中内容要发送的地址，将协议族（例如`struct sockaddr_in`或`struct sockaddr_in6`）作为一个适当的`struct sockaddr`存储在一个`CFData`对象中。如果是`NULL`，`data`被发送到`s`已经连接的地址。`data`对象的使用时间仅仅实在该函数的调用时间中。
`data` | 要发送的数据。
`timeout` | 等待`data`被发送的超时时间。

####返回值
指示成功或失败的错误码。

####讨论
这个函数设置了底层socket（`SOL_SOCKET`等级的`SO_SNDTIMEO`选项）的发送超时时间。然后使用提供的`data`调用`sent`（或者`sendto`，如果你提供了一个地址）。
这个函数没有尝试在超出socket提供的队列之后传入数据队列来缓存它自己。这意味着：

- 如果这个函数返回`kCFSocketSuccess`，然后按时间返回，数据已经传递到socket的缓冲区队列中。
- 如果socket的缓冲区已经满了并且超时时间为0，这个函数可能返回一个错误。如果发生了，app应该在调用这个函数之前等待socket缓冲区拥有足够的可用空间来写入数据。

####可用性
iOS 2.0或2.0之后可用。

##回调

###CFSocket不同类型的回调

`CFSocketCallBack`

当某些类型的活动在`CFSocket`对象中发生的时候回调被调用。

####声明
`typedef void (*CFSocketCallBack) ( CFSocketRef s, CFSocketCallBackType callbackType, CFDataRef address, const void *data, void *info );`

####参数

参数 | 描述
--- | ---
`s` | 经历一些活动的`CFSocket`对象。
`callBackTypes` | 活动检测的类型。
`address` | `s`协议族（例如`struct sockaddr_in`和`struct sockaddr_in6`）的持有一个适当`struct sockaddr`内容的`CFData`对象。
`data` | 毁掉类型的数据。对于一个`kCFSocketConnectCallBack`，他会在后台失败。它是一个指向`SInt32`错误编码的指针。对于`kCFSocketAcceptCallBack`，他是一个指向`CFSocketNativeHandle`的指针。对于`kCFSocketDataCallBack`,它是一个包含正在到达的数据的`CFData`对象。对于其他情况，它是`NULL`。
`info` | `info`是`CFSocketContext`结构体成员，用于创建`CFSocket`对象。

####讨论
当你使用`CFSocketCreate`，`CFSocketCreateConnectedToSocketSignature`， `CFSocketCreateWithNative`或`CFSocketCreateWithSocketSignature`创建`CFSocket`对象的时候指定这个回调。

####可用性
iOS 2.0和2.0之后可用。

##数据类型

###不同类型

`CFSocketContext`
一个包含程序定义的数据和回调，你可以用来配置一个`CFSocket`对象的行为。

####声明
`struct CFSocketContext { CFIndex version; void *info; CFAllocatorRetainCallBack retain; CFAllocatorReleaseCallBack release; CFAllocatorCopyDescriptionCallBack copyDescription; }; typedef struct CFSocketContext CFSocketContext;`

####字段
`version`
结构体的版本号。必须为0。

`info`
一个任意的指针指向程序定义的数据，它可以在创建的时候与`CFSocket`对象连接。这个指针传入了在上下文中定义的所有回调。

`retain`
对你的程序定义的`info`指针的引用回调。可以为`NULL`。

`release`
对你的程序定义的`info`指针的释放回调。可以为`NULL`。

`copyDescription`
对你的程序定义的`info`指针的复制描述回调。可以为`NULL`。

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketNativeHandle`
用于特定平台的本地socket句柄的类型。

####声明
`typedef int CFSocketNativeHandle;`

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketRef`
一个`CFSocket`对象的引用。

####声明
`typedef struct __CFSocket *CFSocketRef;`

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocketSignature`
一个完全指定通信协议和`CFSocket`对象连接地址的结构体。

####声明
`struct CFSocketSignature { SInt32 protocolFamily; SInt32 socketType; SInt32 protocol; CFDataRef address; }; typedef struct CFSocketSignature CFSocketSignature;`

####字段
`protocolFamily`
socket的协议族。

`socketType`
socket的类型。

`protocol`
socket的协议类型。

`address`
对于指定协议族（例如`struct sockaddr_in`或`struct sockaddr_in6`）的持有`struct sockaddr`适当内容的`CFData`对象。

####可用性
iOS 2.0和2.0之后可用。

##常量

###不同类型

`CFSocketCallBackType`
socket活动的类型，可以造成`CFSocket`对象的回调函数被调用。

####声明
```
enum CFSocketCallBackType {
   kCFSocketNoCallBack = 0,
   kCFSocketReadCallBack = 1,
   kCFSocketAcceptCallBack = 2,
   kCFSocketDataCallBack = 3,
   kCFSocketConnectCallBack = 4,
   kCFSocketWriteCallBack = 8
};
typedef enum CFSocketCallBackType CFSocketCallBackType;

```
####常量

- `kCFSocketNoCallBack`

	对于任何活动都不会造成回调。
	iOS 2.0和2.0之后可用。

- `kCFSocketReadCallBack`	

	当数据可以被读出或一个新的连接正在等待被接收的时候回调被调用。数据不会自动读取。回调必须自己读取数据
	
- `kCFSocketAcceptCallBack`

	新的连接将会自动接受并且回调通过一个指向子socket的`CFSocketNaticeHandle`数据参数被调用。这个回调只用于监听socket。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketDataCallBack`

	新到达的数据将会在后台的程序块中被读取并且回调通过一个包含读取数据的`CFData`对象的数据参数被调用。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketConnectCallBack`

	如果一个连接尝试通过调用带有一个本地的超时时间值的`CFSocketConnectToAddress`或`CFSocketCreateConnectedToSocketSignature`在后台创建，毁掉类型会在连接完成时被创建。在这种情况下，数据参数是`NULL`，如果连接失败，就是一个指向`SInt32`错误编码的指针。对于一个指定的socket，回调最多会发送一次。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketWriteCallBack`

	当socket是可写入的时候回调被调用。当大量数据快速的通过socket发送时，当内核缓冲区有缓存更多数据的空间的时候你想要一个通知，这个回调可能是有用的。
	iOS 2.0和2.0之后可用。
	
####讨论
一个回调的回调类型在`CFSocket`对象被创建的时候就被确定。例如使用`CFSocketCreate`或者之后使用`CFSocketEnableCallBacks`和`CFSocketDisableCallBacks`。

`kCFSocketReadCallBack`，`kCFSocketAcceptCallBack`和`kCFSocketDataCallBack`回调是互斥的。

####可用性
iOS 2.0和2.0之后可用。

----

`CFSocket Flags`
可以在`CFSocket`对象中设置已控制其行为的标识。

####声明
```
enum {
   kCFSocketAutomaticallyReenableReadCallBack = 1,
   kCFSocketAutomaticallyReenableAcceptCallBack = 2,
   kCFSocketAutomaticallyReenableDataCallBack = 3,
   kCFSocketAutomaticallyReenableWriteCallBack = 8,
   kCFSocketLeaveErrors = 64,
   kCFSocketCloseOnInvalidate = 128
};

```

####常量

- `kCFSocketAutomaticallyReenableReadCallBack`

	当启用`CFSocketSetSocketFlags`时，每次socket有数据可以被读取的时候接收回调就会被调用。当不可用的时候，当下一次数据可用时读取回调只会被调用一次。默认情况下读取会调自动重新启用。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketAutomaticallyReenableAcceptCallBack`

	当启用`CFSocketSetSocketFlags`时，每次有人连接到你的socket的时候，接收回调就会被调用。当不可用的时候，下一次一个新的socket连接被接收的时候，接收回调只会被调用一次。默认情况下，接收回调会自动重新启用。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketAutomaticallyReenableDataCallBack`

	当启用`CFSocketSetSocketFlags`时，每次有更多的数据被写入到socket中的时候，写入回调就会被调用。当不可用的时候，仅当下一次数据可以被写入的时候，写入回调被调用。默认情况下，写入回调不会被自动重新启用。
	iOS 2.0和2.0之后可用。

- `kCFSocketLeaveErrors`

	通常，`CFNetwork`堆栈在socket中通过调用`getsockopt(2) Mac OS X Developer Tools Manual Page`读取错误码要优先于调用你的写入回调。这也有清除socket上的任何将要发生的错误的效果。
	如果设置这个标志，则跳过这个调用，以便于你能在你的写入回调中检查特定的socket错误。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketCloseOnInvalidate`

	当启用`CFSocketSetSocketFlags`时，当`CFSocket`对象失效时，与`CFSocket`对象相连的贝蒂socket被关闭。当不可用时，本地socket保持打开。默认此选项是启用的。
	iOS 2.0和2.0之后可用。
	
####讨论
`CFSocket`对象的标志通过`CFSocketSetSocketFlags`设置。要立即启用或禁用一个回调，使用`CFSocketEnableCallBacks`和`CFSocketDisableCallBacks`。

----

`CFSocketError`
一些`CFSocket`函数的错误码。

####声明
```
enum CFSocketError {
   kCFSocketSuccess = 0,
   kCFSocketError = -1,
   kCFSocketTimeout = -2
};
typedef enum CFSocketError CFSocketError;

```

####常数

- `kCFSocketSuccess`

	socket操作成功。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketError`
	
	socket操作失败。
	iOS 2.0和2.0之后可用。
	
- `kCFSocketTimeout`

	socket操作超时。
	iOS 2.0和2.0之后可用。
	
####可用性
iOS 2.0和2.0之后可用。

