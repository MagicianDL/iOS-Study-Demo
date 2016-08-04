//
//  Person.h
//  KVC
//
//  Created by Dalang on 16/8/4.
//  Copyright © 2016年 SYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject

@property (nonatomic, strong) Dog *dog;

@property (nonatomic, strong) NSArray <Dog *> *dogs;

@end
