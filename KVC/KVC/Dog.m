//
//  Dog.m
//  KVC
//
//  Created by Dalang on 16/8/4.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "Dog.h"

@implementation Dog

- (NSString *)description
{
    return [NSString stringWithFormat:@"Dog: name: %@, weight: %@", self.name, self.weight];;
}

@end
