//
//  MSCAppDelegate.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 28.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCAppDelegate.h"

@implementation MSCAppDelegate

@synthesize window;
@synthesize preferencesWindow;
@synthesize directories;
@synthesize directoriesController;
@synthesize preferences;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSMenu* rootMenu = [NSApp mainMenu];
    [rootMenu removeItemAtIndex: [rootMenu indexOfItemWithSubmenu:fileMenu]];
    [rootMenu removeItemAtIndex: [rootMenu indexOfItemWithSubmenu:viewMenu]];
    [rootMenu removeItemAtIndex: [rootMenu indexOfItemWithSubmenu:formatMenu]];
    
    preferences = [[MSCPreferences alloc] init];
    mpd         = [MSCMpdClient mpd: preferences];
    
    [self.preferencesWindow orderOut:self];
    [self.window makeFirstResponder: patternField];
    [self statusClick: nil];
    
    statusTimer = [NSTimer scheduledTimerWithTimeInterval:15
                                                   target:self
                                                 selector:@selector(updateStatusWithTimer:)
                                                 userInfo:nil
                                                  repeats:YES];
}

// Playlist management
// ===================

- (IBAction) addClick:(id)sender {
    NSUInteger index = [self.directoriesController selectionIndex];
    MSCDir*    dir   = [self.directories objectAtIndex: index];
    
    [mpd add: [dir path]];
    [self playlistClick: nil];
}

- (IBAction) clearClick:(id)sender {
    [mpd clear];
    self.songs = [NSMutableArray array];
}

- (IBAction) addDirToPlaylist:(id)sender {
    [self addClick:nil];
}

- (IBAction) setDirAsPlaylist:(id)sender {
    [self clearClick:nil];
    [self addClick:nil];
}

// Status detection
// ================

- (IBAction) statusClick:(id)sender {
    [self playlistClick:nil];
    
    MSCStatus* status = [mpd status];
    [statusField setTitle: [status description]];
    
    NSUInteger idx = [[self songs] indexOfObject: [MSCDir dirWithName:[status title]]];
    if (idx != NSNotFound) {
        [[self songsController] setSelectionIndex:idx];
        
        [songsView scrollRowToVisible:idx];
    }
}

// Playback control
// ================

- (IBAction) playClick:(id)sender {
    if (isInPlaylist) {
        NSUInteger index = [self.songsController selectionIndex];
        if (index != NSNotFound) {
            [mpd play: index];
        }
    }
}

- (IBAction) playPreviousClick:(id)sender {
    [mpd previous];
}

- (IBAction) playNextClick:(id)sender {
    [mpd next];
}

// Listings
// ========

- (IBAction) searchClick:(id)sender {
    NSMutableArray* arr = [NSMutableArray array];
    
    for (NSString* dir in [mpd ls: [patternField stringValue]]) {
        [arr addObject: [MSCDir dirWithName:dir]];
    }
    
    self.directories = arr;
    [self.window makeFirstResponder: patternField];
}

- (IBAction) listClick:(id)sender {
    NSUInteger      index = [self.directoriesController selectionIndex];
    MSCDir*         dir   = [self.directories objectAtIndex: index];
    NSMutableArray* arr   = [NSMutableArray array];
    
    [patternField setStringValue:[dir path]];
    
    for (NSString* song in [mpd listall: [dir path]]) {
        [arr addObject: [MSCDir dirWithPath:song]];
    }
    
    self.songs = arr;
    isInPlaylist = FALSE;
}

- (IBAction) playlistClick:(id)sender {
    NSMutableArray* arr   = [NSMutableArray array];
    
    for (NSString* song in [mpd playlist]) {
        [arr addObject: [MSCDir dirWithPath:song]];
    }
    
    self.songs = arr;
    isInPlaylist = TRUE;
}

// Preferences actions
// ===================

- (IBAction) showPreferences:(id)sender {
    if (self.preferencesWindow.isVisible) {
        [self.preferencesWindow orderOut:self];
    } else {
        NSRect pos = [self.window frame];
        NSRect old = [self.preferencesWindow frame];
        
        // center owner
        old.origin.x = pos.origin.x + (pos.size.width / 2) - (old.size.width / 2);
        old.origin.y = pos.origin.y + (pos.size.height / 2) - (old.size.height / 2);
        
        [self.preferencesWindow setFrame:old display:YES];
        [self.preferencesWindow makeKeyAndOrderFront:self];
    }
}

- (IBAction) savePreferencesClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction) resetPreferencesClick:(id)sender {
    [preferences reset];
}

// Helper methods
// ==============

- (void) updateStatusWithTimer: (NSTimer*)timer {
    [self updateStatus];
}

- (void) updateStatus {
    [statusField setTitle: [[mpd status] description]];
}


@end
