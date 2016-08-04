# iOS KVC
##KVC（Key - Value Coding）
KVC常见的用途

1. 给私有的成员变量赋值（公有的也可以）
	
	  比如一个类有一个私有成员变量（在.m文件中），用KVC的方式然后可以对这个私有成员变量进行取值和赋值操作。

	```
	Person *person = [[Person alloc] init];
	[person setValue:@(18) forKey: @"age"];
	
	```
	Person类有一个私有成员变量`_age`，可以使用KVC方式对这个私有变量进行取值和赋值操作。
	
	```
	[person setValueForKey:@(18)];
	NSNumber *age = [person valueForKey:@"age"];
	
	```
	这里有几点需要注意：
	- value的值一定是对象，所以即使person的私有成员变量`_age`是`int`类型的，但是`setValue`的时候要将其赋值为对象类型的。在进行取值操作的时候，这里使用`NSNumber`类型的指针指向这个对象，也可以用`NSString`类型的指针，因为`valueForKey:`返回的是`id`类型。
	- 可以看到私有成员变量_age是有下划线的，但是无论KVC在赋值还是取值的时候用到的`age`都是没有下划线的，这样也可以成功访问这个值。因为使用KVC的方式，会首先寻找age这个没有下划线的成员变量，如果查找不到，会继续查找`_age`这个有下划线的成员变量，所以使用KVC的时候无论加不加下划线都可以。
	- `valueForKeyPath:`方法更强大，因为用它可以访问对象中的对象属性的对象属性......就像一个path一样可以一直访问下去。
	
2. 字典转模型

   比如我们有一个字典
   
   ```
   NSDictionary *dict = @{@"name": @"Joyann", @"age": @18};
 
   ```
   我们可以直接将字典转换为数据模型person：
   
   ```
   Person *person = [[Person alloc] init];
   NSDictionary *dict = @{@"name": @"Joyann", @"age": @18};
   [person setValuesForKeysWithDictionary:dict];
   
   ```
   注意：在使用`setValuesForKeysWithDictionary:`方法进行字典转模型的时候，要求字典的key和模      型类的属性的名族要相同，并且key的数量不能多于类的属性数量，因为这样就会造成有的key不能找到相应的属性。但是key得数量可以少于类的属性数量，这样就是有的类属性不需要赋值（被转换），但是也要保证key和对应的类属性名字要相同。
   
   上面只是简单的转换。
   
   如果模型类有一个模型属性，那么需要传入字典的元素也是一个字典：
   
   ```
   NSDictionary *dict = @{@"name": @"Joyann", @"age": @(18), @"dog": @{@"name":@"A", @"weight": @(12.0)}};
   
   ```
   
   此时想将dict这个字典转换为数据模型则需要下面的操作：
   
   
   ```
   NSDictionary *dict = @{@"name": @"Joyann", @"age": @(18), @"dog": @{@"name":@"A", @"weight": @(12.0)}};
[person setValusForKeysWithDicatonary: personDict];
  person.dog = [[Dog alloc] init]; // 让指向字典的dog重新指向Dog对象
  [person.dog setValuesForKeysWithDictonary: personDict[@"dog"]];

   ```
   当给person发送`setValusForKeysWithDicatonary`消息的时候，实际上此时它的dog属性的指针指向了一个字典，而不是Dog类的对象。如果此时打印person.dog的类型，其实是NSDictionary类型。此时当访问person.dog.name的时候会报错，因为dog不是指的不是一个对象，而是一个字典。

	所以在上面的例子中，首先要将`person.dog`重新指向一个`Dog`对象，然后再将字典转换成对应的模型数据。

	还有一种情况，比如一个模型类里面的一个属性是`NSArray`，这个数组里面包含的是其它的对象属性。

	比如`Person`类里面：
	
	```
    @property (nonatomic, strong) NSArray *dogs;
	
	```

	另外还有一个需要被转换的字典：
	
	```
	
	NSDictionary *dict = @{
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
	
	```
	
	此时情况就很复杂。我们需要遍历这个数组，将其中的字典元素转换成对应的模型数据。
	

	```
	
	NSDictionary *dict = @{
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
	[person setValuesForKeysWithDictionary: personDict];

	NSMutableArray *tempDogs = [NSMutableArray array];
	for (NSDictionary *dogDict in person.dogs) {
    	Dog *dog = [[Dog alloc] init];
        [dog setValuesForKeysWithDictionary: dogDict];
        [tempDogs addObject: dog];
	}

	person.dogs = tempDogs;
	
	```
	
3. 用KVC进行取值的补充

   - 前面提到，给一个对象发送`valueForKeyPath:`也会提到这个key对应的value的值。如果给一个对象的数组属性发送这个消息，那么会得到这个数组中的对象的value组成的数组。
   
   ```
   NSArray *names = [person.dogs valueForKeyPath:@"name"];
   
   ```
   
   - 其它应用：
   
   
 	```
   
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
   
   ```
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   


	
