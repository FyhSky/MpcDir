//
//  MSCDirectoriesDelegate.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 14.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSCDirectoriesDelegate
@required

- (void) viewDirectory;
- (void) goInsideDirectory;
- (void) goOutsideDirectory;

@end
