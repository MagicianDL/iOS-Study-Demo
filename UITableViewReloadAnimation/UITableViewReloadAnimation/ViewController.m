//
//  ViewController.m
//  UITableViewReloadAnimation
//
//  Created by Dalang on 16/8/23.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+ReloadAnimation.h"
#import "UITableViewCell+LoadAnimation.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_heights;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _heights = @[@44, @88, @132, @88, @44];
    
    
    
}

- (IBAction)reload:(id)sender {
    [self.tableView reloadDataWithDirection:DLLoadAnimationDirectionTypeRight duration:0.1 offset:0.1];
//    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"UITableViewReloadAnimation - %ld", indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = arc4random() % 5;
    NSNumber *number = _heights[index];
    
    return (CGFloat)number.floatValue;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    [cell displayWithDirection:DLLoadAnimationDirectionTypeRight duration:.65 delay:0 springDamping:.85 springVelocity:.8];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
