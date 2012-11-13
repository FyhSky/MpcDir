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

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    
    if ([theEvent modifierFlags] & NSNumericPadKeyMask) { // is arrow pressed ?
        NSString* theArrow = [theEvent charactersIgnoringModifiers];
        unichar    keyChar = 0;
        
        if ( [theArrow length] == 0 ) {
            return;            // reject dead keys
        }
        if ( [theArrow length] == 1 ) {
            keyChar = [theArrow characterAtIndex:0];
            
            if ( keyChar == NSLeftArrowFunctionKey ) {
                [directoryDelegate goOutsideDirectory];
                [self sendAction: self.action to:self.target];
                return;
            }
            if ( keyChar == NSRightArrowFunctionKey ) {
                [directoryDelegate goInsideDirectory];
                [self sendAction: self.action to:self.target];
                return;
            }
            
            if ( keyChar == NSUpArrowFunctionKey || keyChar == NSDownArrowFunctionKey ) {
                [super keyDown:theEvent];
                [self sendAction: self.action to:self.target];
                [directoryDelegate viewDirectory];
                return;
            }
            [super keyDown:theEvent];
        }
    }
    
    [super keyDown:theEvent];
}


@end
