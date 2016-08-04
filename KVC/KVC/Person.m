//
//  Person.m
//  KVC
//
//  Created by Dalang on 16/8/4.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic, copy) NSString *name;

@end

@implementation Person
{
    NSNumber *_age;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Person: name: %@, age: %@, dog: %@, dogs: %@", self.name, _age, self.dog, self.dogs];
}



@end
