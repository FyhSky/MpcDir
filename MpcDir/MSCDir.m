//
//  MSCDir.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 28.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCDir.h"

@implementation MSCDir

@synthesize name;
@synthesize path;

+ (MSCDir*) dirWithName: (NSString*)aName andPath: (NSString*)aPath
{
    MSCDir* dir = [[MSCDir alloc] init];
    [dir setName:aName withPath:aPath];
    return dir;
}

+ (MSCDir*) dirWithName: (NSString*)aName
{
    return [MSCDir dirWithName:aName andPath:aName];
}

+ (MSCDir*) dirWithPath:(NSString*)aPath
{
    return [MSCDir dirWithName: [aPath lastPathComponent] andPath: aPath];
}

- (void) setName:(NSString*)aName withPath:(NSString*)aPath
{
    self.name = aName;
    self.path = aPath;
}

- (BOOL) isEqual:(id)other {
    if ([other isKindOfClass:[MSCDir class]]) {
        return [[self name] isEqual: [other name]];
    } else if ([other isKindOfClass:[NSString class]]) {
        return [[self name] isEqual: other];
    } else {
        return NO;
    }
}

- (NSUInteger) hash {
    return [[self name] hash];
}

- (NSString*) description {
    return self.name;
}

- (id)valueForUndefinedKey: (NSString*) key {
    return @"";
}

@end
