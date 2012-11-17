//
//  MSCSong.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 17.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FindBlock) (NSUInteger);

@interface MSCSong : NSObject

@property NSString* data;
@property NSString* position;
@property NSString* title;
@property NSString* artist;
@property NSString* album;
@property NSString* year;

+ (MSCSong*) songWithData: (NSString*)data;
- (NSUInteger) findMeIn:(NSArray*) songs;

@end
