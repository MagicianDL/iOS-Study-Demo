//
//  ViewController.m
//  DLTimer
//
//  Created by Dalang on 16/8/11.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "DLTimer.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
#error this class is only ready to work on iOS6
#endif

static const char *DLViewControllerTimerQueueContext = "DLViewControllerTimerQueueContext";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) DLTimer *timer;

@property (strong, nonatomic) DLTimer *backgroundTimer;

@property (strong, nonatomic) dispatch_queue_t privateQueue;




@end

@implementation ViewController

- (void)dealloc
{
    [_timer invalidate];
    [_backgroundTimer invalidate];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _privateQueue = dispatch_queue_create("com.dalang.private_queue", DISPATCH_QUEUE_CONCURRENT);
        _backgroundTimer = [DLTimer scheduledTimerWithTimeInterval:0.2
                                                            target:self
                                                          selector:@selector(backgroundTimerDidFire)
                                                          userInfo:nil
                                                           repeats:YES
                                                     dispatchQueue:self.privateQueue];
        
        dispatch_queue_set_specific(self.privateQueue, (__bridge const void *)(self), (void *)DLViewControllerTimerQueueContext, NULL);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)toggleTimer:(UIButton *)sender
{
    static NSString *kStopTimerText = @"Stop";
    static NSString *kStartTimerText = @"Start";
    
    NSString *currentTitle = [sender titleForState:UIControlStateNormal];
    
    if ([currentTitle isEqualToString:kStopTimerText])
    {
        [sender setTitle:kStartTimerText forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    else
    {
        [sender setTitle:kStopTimerText forState:UIControlStateNormal];
        self.timer = [DLTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(mainThreadTimerDidFire:)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
    }
}

- (IBAction)fireTimer
{
    [self.timer fire];
}

- (void)mainThreadTimerDidFire:(DLTimer *)timer
{
    NSAssert([NSThread isMainThread], @"This should be called from the main thread");
    
    self.label.text = [NSString stringWithFormat:@"%ld", [self.label.text integerValue] + 1];
}

- (void)backgroundTimerDidFire
{
    NSAssert(![NSThread isMainThread], @"This shouldn't be called from the main thread");
    
    const BOOL calledInPrivateQueue = dispatch_queue_get_specific(self.privateQueue, (__bridge const void *)(self)) == DLViewControllerTimerQueueContext;
    NSAssert(calledInPrivateQueue, @"This should be called on the provided queue");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
