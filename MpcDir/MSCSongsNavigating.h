//
//  MSCSongsNavigating.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 14.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

// Songs navigation protocol
//   provides a way to handle navigation key presses
//   in songs view (right pane)
//
@protocol MSCSongsNavigating <NSObject>
@required

// Play selected song
- (void) playSong;

@end
