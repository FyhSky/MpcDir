//
//  MSCStatus.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 11.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCSong.h"

typedef enum {
    MSC_STATUS_PLAYING,
    MSC_STATUS_PAUSED,
    MSC_STATUS_STOPPED
    
} MSCStatusType;

@interface MSCStatus : NSObject

@property MSCStatusType status;
@property MSCSong* song;
@property NSUInteger playlistIndex;
@property NSUInteger playlistLength;
@property BOOL repeat;
@property BOOL random;
@property BOOL single;
@property BOOL consume;

+ (id) statusWithArray: (NSArray*)data;

@end
