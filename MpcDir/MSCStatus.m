//
//  MSCStatus.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 11.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCStatus.h"

// PLAYING
// --------------------------------------------------------------------
// Megumi Hayashibara - Life
// [playing] #28/202   3:10/4:07 (76%)
// volume: 84%   repeat: on    random: off   single: off   consume: off
// --------------------------------------------------------------------

// PAUSED
// --------------------------------------------------------------------
// Megumi Hayashibara - Life
// [paused] #28/202   3:10/4:07 (76%)
// volume: 84%   repeat: on    random: off   single: off   consume: off
// --------------------------------------------------------------------

// STOPPED
// --------------------------------------------------------------------
// volume: 84%   repeat: on    random: off   single: off   consume: off
// --------------------------------------------------------------------

@implementation MSCStatus

@synthesize status;
@synthesize title;
@synthesize playlistIndex;
@synthesize playlistLength;

+ (id) statusWithArray: (NSArray*)data {
    MSCStatus* st = [[MSCStatus alloc] init];
    
    //NSLog(@"parsing status array: %@", data);
    
    if (st) {
        
        if (data.count <= 2) {
            st.title = @"";
            st.status = MSC_STATUS_STOPPED;
            st.playlistIndex = 0;
            st.playlistLength = 0;
        } else {
            st.title = data[0];
            
            if ([data[1] rangeOfString: @"[playing]"].location != NSNotFound) {
                st.status = MSC_STATUS_PLAYING;
            } else if ([data[1] rangeOfString:@"[paused]"].location != NSNotFound) {
                st.status = MSC_STATUS_PAUSED;
            } else {
                st.status = MSC_STATUS_STOPPED;
            }
            
            st.playlistIndex = 0;
            st.playlistLength = 0;
        }
    }
    
    return st;
}

- (NSString*) description {
    if (self.status == MSC_STATUS_STOPPED) {
        return @"stopped";
    } else if (self.status == MSC_STATUS_PLAYING) {
        return [NSString stringWithFormat:@"Now playing: %@", self.title];
    } else if (self.status == MSC_STATUS_PAUSED) {
        return [NSString stringWithFormat:@"Paused on: %@", self.title];
    } else {
        return @"unknown status";
    }
}

@end
