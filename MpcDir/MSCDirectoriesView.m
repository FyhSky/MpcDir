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

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
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
                [self handleArrowLeft];
                return;
            }
            if ( keyChar == NSRightArrowFunctionKey ) {
                [self handleArrowRight];
                return;
            }
            if ( keyChar == NSUpArrowFunctionKey ) {
                [self handleArrowUp];
                [super keyDown:theEvent];
                [self sendAction: self.action to:self.target];
                return;
            }
            if ( keyChar == NSDownArrowFunctionKey ) {
                [self handleArrowDown];
                [super keyDown:theEvent];
                [self sendAction: self.action to:self.target];
                return;
            }
            [super keyDown:theEvent];
        }
    }
    
    [super keyDown:theEvent];
}

- (void) handleArrowLeft {
    NSLog(@"<-");
}

- (void) handleArrowRight {
    NSLog(@"->");
}

- (void) handleArrowUp {
    NSLog(@"^");
}

- (void) handleArrowDown {
    NSLog(@"v");
}

@end
