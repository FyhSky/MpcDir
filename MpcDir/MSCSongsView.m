//
//  MSCSongsView.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 14.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCSongsView.h"

@implementation MSCSongsView

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
        
        if ( key == NSEnterCharacter ||
             key == NSCarriageReturnCharacter ||
             key == MSCSpacebar)
        {
            [self sendAction: self.action to:self.target];
            [songDelegate playSong];
            return;
        }
        
        if ( key == NSUpArrowFunctionKey ||
             key == NSDownArrowFunctionKey )
        {
            [super keyDown:theEvent];
            [self sendAction: self.action to:self.target];
            return;
        }
        
        [super keyDown:theEvent];
    }
}

@end
