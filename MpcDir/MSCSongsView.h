//
//  MSCSongsView.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 14.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCSongsNavigating.h"

#define MSCSpacebar 32

// Simple table view but provides a way to
//   handle key presses for songs navigation,
//   and simulates click action after navigation events
//   because current song changes (that IS a click).
//
@interface MSCSongsView : NSTableView
{
    // A way to hook into keypresses
    IBOutlet id<MSCSongsNavigating> songDelegate;
}

@end
