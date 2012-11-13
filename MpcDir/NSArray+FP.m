//
//  NSArray+FP.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 13.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "NSArray+FP.h"

@implementation NSArray (FP)

- (NSArray *)map:(MapBlock)block {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (id object in self) {
        [resultArray addObject:block(object)];
    }
    return resultArray;
}

- (NSArray*) sliceAt:(NSUInteger)location ofLength:(NSUInteger)length {
    NSRange range;
    range.location = location;
    range.length = length;
    
    return [self subarrayWithRange:range];
}

- (NSString*) stringByJoiningPathComponents {
    NSString* path = @"";
    
    for(NSString* newPart in self) {
        path = [newPart isAbsolutePath] ?
                [NSString stringWithString:newPart] :
                [path stringByAppendingPathComponent:newPart];
    }
    
    return path;
}

@end
