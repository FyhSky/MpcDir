//
//  MSCDirectoriesView.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 13.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCDirectoriesView.h"

@implementation MSCDirectoriesView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// Handle all keypresses
//
- (void)keyDown:(NSEvent *)theEvent {
    
    NSString* theArrow = [theEvent charactersIgnoringModifiers];
    unichar   key = 0;
    
    if ( [theArrow length] == 0 ) {
        return;            // reject dead keys
    }
    
    if ( [theArrow length] == 1 ) {
        key = [theArrow characterAtIndex:0];
            
        if ( key == NSLeftArrowFunctionKey ||
             key == NSDeleteCharacter )
        {
            [directoryDelegate goOutsideDirectory];
            [self sendAction: self.action to:self.target];
            return;
        }
        
        if ( key == NSRightArrowFunctionKey ||
             key == NSEnterCharacter ||
             key == NSCarriageReturnCharacter ||
             key == MSCSpacebar)
        {
            [directoryDelegate goInsideDirectory];
            [self sendAction: self.action to:self.target];
            return;
        }
        
        if ( key == NSUpArrowFunctionKey ||
             key == NSDownArrowFunctionKey )
        {
            [super keyDown:theEvent];
            [self sendAction: self.action to:self.target];
            [directoryDelegate viewDirectory];
            return;
        }
        
        [super keyDown:theEvent];
    }
}

@end
