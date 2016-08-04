//
//  main.m
//  KVC
//
//  Created by Dalang on 16/8/4.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *person = [[Person alloc] init];
        [person setValue:@18 forKey:@"age"];
        NSNumber *age = [person valueForKey:@"age"];
        NSLog(@"%@", age);
        
        
        NSDictionary *dict = @{ @"name": @"Joyann", @"age": @18};
        [person setValuesForKeysWithDictionary:dict];
        NSLog(@"%@", person);
        
        
        dict = @{@"name": @"Joyann", @"age": @(18), @"dog": @{@"name":@"A", @"weight": @(12.0)}};
        [person setValuesForKeysWithDictionary:dict];
        person.dog = [[Dog alloc] init];
        [person.dog setValuesForKeysWithDictionary:dict[@"dog"]];
        NSLog(@"%@", person);
        
        dict = @{
                 @"name": @"Joyann",
                 @"age": @(18),
                 @"dog": @{
                           @"name": @"A",
                           @"weight": @(12.0)
                           },
                 @"dogs": @[
                            @{@"name": @"B", @"weight": @(13.0)},
                            @{@"name": @"C", @"weight": @(14.0)},
                            @{@"name": @"D", @"weight": @(15.0)}
                           ]
                 };
        [person setValuesForKeysWithDictionary:dict];
        person.dog = [[Dog alloc] init];
        [person.dog setValuesForKeysWithDictionary:dict[@"dog"]];
        NSMutableArray *dogs = [NSMutableArray array];
        for (NSDictionary *dogDict in dict[@"dogs"]) {
            Dog *dog = [[Dog alloc] init];
            [dog setValuesForKeysWithDictionary:dogDict];
            [dogs addObject:dog];
        }
        person.dogs = dogs;
        NSLog(@"%@", person);
        
        // 此时得到的就是dogs这个数组中各个对象的name属性组成的数组
        NSArray *names = [person.dogs valueForKeyPath:@"name"];
        NSLog(@"%@", names);
        
        // 取出dog数组中的最大值
        NSLog(@"max:%@", [person.dogs valueForKeyPath:@"@max.weight"]);
        // 取出dog数组中的最小值
        NSLog(@"min:%@", [person.dogs valueForKeyPath:@"@min.weight"]);
        // 取出dog数组的平均值
        NSLog(@"avg:%@", [person.dogs valueForKeyPath:@"@avg.weight"]);
        // 取出dog数组的个数
        NSLog(@"count:%@", [person.dogs valueForKeyPath:@"@count.weight"]);
        // 取出价格数组的总和
        NSLog(@"sum:%@", [person.dogs valueForKeyPath:@"@sum.weight"]);
        
        
      
        
        
        
    }
    return 0;
}
