//
//  MSCDirectoriesView.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 13.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCDirectoriesDelegate.h"

@interface MSCDirectoriesView : NSTableView
{
    IBOutlet id<MSCDirectoriesDelegate> directoryDelegate;
}

@end
