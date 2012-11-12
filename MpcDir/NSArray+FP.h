//
//  NSArray+FP.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 13.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^MapBlock)(id);

@interface NSArray (FP)

- (NSArray *)map:(MapBlock)block;

@end
