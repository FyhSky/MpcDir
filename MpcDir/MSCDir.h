//
//  MSCDir.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 28.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCDir : NSObject
{
    NSString* _name;
    NSString* _path;
}

+ (MSCDir*) dirWithName: (NSString*)aName andPath: (NSString*)aPath;
+ (MSCDir*) dirWithName: (NSString*)aName;
+ (MSCDir*) dirWithPath: (NSString*)aPath;

- (NSString*) name;
- (NSString*) path;
- (void) setName:(NSString*)aName withPath:(NSString*)aPath;

@end
