//
//  MSCDirectoriesDelegate.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 14.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

// Directories navigation protocol
//   provides a way to handle navigation key presses
//   in directories view (left pane)
//
@protocol MSCDirectoriesNavigating
@required

// List directory in search field
- (void) viewDirectory;

// List directory under directories view cursor
- (void) goInsideDirectory;

// List parent directory is search field
- (void) goOutsideDirectory;

@end
