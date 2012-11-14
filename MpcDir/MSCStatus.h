//
//  MSCStatus.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 11.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    MSC_STATUS_PLAYING,
    MSC_STATUS_PAUSED,
    MSC_STATUS_STOPPED
    
} MSCStatusType;

@interface MSCStatus : NSObject

@property MSCStatusType status;
@property NSString* title;
@property NSUInteger playlistIndex;
@property NSUInteger playlistLength;
@property BOOL repeat;
@property BOOL random;
@property BOOL single;
@property BOOL consume;

+ (id) statusWithArray: (NSArray*)data;

@end
