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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)reload:(id)sender {
//    [self.tableView reloadDataWithDirection:DLLoadAnimationDirectionTypeRight duration:0.1 offset:0.1];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"UITableViewReloadAnimation - %ld", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [cell displayWithDirection:DLLoadAnimationDirectionTypeRight duration:.65 delay:0 springDamping:.85 springVelocity:.8];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
