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
    
    preferences = [MSCPreferences preferences];
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
    [mpd add: [self currentDirectoryPath]];
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
    self.directories = [mpd ls: [patternField stringValue] withBlock:^(id dir) {
        return [MSCDir dirWithPath:dir];
    }];
    [self.window makeFirstResponder: patternField];
}

- (IBAction) listClick:(id)sender {
    NSString* path = [self currentDirectoryPath];
    
    [patternField setStringValue: path];
    
    self.songs = [mpd listall: path withBlock:^(id song) {
        return [MSCDir dirWithPath:song];
    }];
    isInPlaylist = FALSE;
}

- (IBAction) playlistClick:(id)sender {
    self.songs = [mpd playlist:^(id song) {
        return [MSCDir dirWithPath:song];
    }];
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

- (MSCDir*) currentDirectory {
    return [self.directories objectAtIndex: self.directoriesController.selectionIndex];
}

- (NSString*) currentDirectoryPath {
    return [[self currentDirectory] path];
}


// MSCDirectoriesNavigating
// ========================

- (void) viewDirectory {
    //NSLog(@"viewDirectory");
}

- (void) goInsideDirectory {
    self.directories = [mpd ls: [self currentDirectoryPath] withBlock:^(id dir) {
        return [MSCDir dirWithPath:dir];
    }];
}

- (void) goOutsideDirectory {
    NSString*      path = [self currentDirectoryPath];
    NSArray* components = [path pathComponents];
    
    if (components.count > 1) {
        path = [[components sliceAt:0
                           ofLength:components.count - 2] stringByJoiningPathComponents];
    } else {
        path = @"";
    }
    
    self.directories = [mpd ls: path withBlock:^(id dir) {
        return [MSCDir dirWithPath:dir];
    }];
}

@end
