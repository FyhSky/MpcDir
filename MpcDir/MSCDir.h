//
//  MSCDir.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 28.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+FP.h"

@interface MSCDir : NSObject

@property NSString* name;
@property NSString* path;

+ (MSCDir*) dirWithName: (NSString*)aName andPath: (NSString*)aPath;
+ (MSCDir*) dirWithName: (NSString*)aName;
+ (MSCDir*) dirWithPath: (NSString*)aPath;

- (MSCDir*) parent;

@end
