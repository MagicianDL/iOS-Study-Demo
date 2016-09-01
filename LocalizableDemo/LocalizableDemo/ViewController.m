//
//  ViewController.m
//  LocalizableDemo
//
//  Created by Dalang on 16/8/31.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "Language.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *helloWorldLabel;
@property (weak, nonatomic) IBOutlet UIImageView *colaImageView;
@property (nonatomic, copy) NSMutableString *currentLanguage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _currentLanguage = [[Language currentLanguageCode] mutableCopy];
    [self reloadUI];
}

- (void)reloadUI {
    self.navigationItem.title = kLang(@"Localizable");
    _helloWorldLabel.text = kLang(@"Hello World");
    [_colaImageView setImage:[UIImage imageNamed:kLang(@"coca_cola")]];
    [self createRightBarItem];
}

- (void)createRightBarItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kLang(@"Toggle") style:UIBarButtonItemStylePlain target:self action:@selector(changeLanguage)];
    rightBarButtonItem.tintColor = [UIColor colorWithRed:0.008 green:0.633 blue:0.890 alpha:1.000];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)changeLanguage {
    
    if ([_currentLanguage isEqualToString:LanguageCode[0]]) {
        _currentLanguage = LanguageCode[1];
    } else if ([_currentLanguage isEqualToString:LanguageCode[1]]) {
        _currentLanguage = LanguageCode[0];
    }
    
    [Language userSelectedLanguage:_currentLanguage];
    
    [self reloadUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
