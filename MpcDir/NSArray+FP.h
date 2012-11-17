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

/// Apply @block to every item in array and @return array of results.
- (NSArray*) map:(MapBlock)block;

/// @return part of array starting at @location of @length.
- (NSArray*) sliceAt:(NSUInteger)location ofLength:(NSUInteger)length;

/// @return string of path components joined with path separator.
- (NSString*) stringByJoiningPathComponents;

@end
