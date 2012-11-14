//
//  MSCDirectoriesView.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 13.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCDirectoriesNavigating.h"

// Simple table view but provides a way to
//   handle key presses for directory navigation,
//   and simulates click action after navigation events
//   because current directory changes (that IS a click).
//
@interface MSCDirectoriesView : NSTableView
{
    // A way to hook into keypresses
    IBOutlet id<MSCDirectoriesNavigating> directoryDelegate;
}

@end
