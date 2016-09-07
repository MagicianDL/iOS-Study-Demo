//
//  ViewController.m
//  DLCircleImageLoader
//
//  Created by Dalang on 16/9/5.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+DLLoader.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.imageView startLoaderWithTintColor:[UIColor redColor]];
    
    __weak typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.gratisography.com/pictures/300_1.jpg"] placeholderImage:nil options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@" %ld %ld", (long)receivedSize, (long)expectedSize);
        [weakSelf.imageView updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf.imageView reveal];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
