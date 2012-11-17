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

@synthesize isInPlaylist;

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
    
    NSUInteger index = [status.song findMeIn:self.songs];
    if (index != NSNotFound) {
        self.songsController.selectionIndex = index;
        [songsView scrollRowToVisible:index];
    }
    [self updateStatus];
}

// Playback control
// ================

- (IBAction) playClick:(id)sender {
    if (self.isInPlaylist) {
        [mpd play: [self currentSongIndex]];
    }
}

- (IBAction) playPreviousClick:(id)sender {
    [mpd previous];
}

- (IBAction) playNextClick:(id)sender {
    [mpd next];
}

- (IBAction) pauseClick:(id)sender {
    [mpd toggle];
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
    self.isInPlaylist = NO;
}

- (IBAction) playlistClick:(id)sender {
    self.songs = [mpd playlist:^(id data) {
        return [MSCSong songWithData:data];
    }];
    self.isInPlaylist = YES;
}

// Mode switches
// =============

- (IBAction) randomClick:(id)sender {
    [mpd random];
    [self updateStatus];
}

- (IBAction) repeatClick:(id)sender {
    [mpd repeat];
    [self updateStatus];
}

- (IBAction) singleClick:(id)sender {
    [mpd single];
    [self updateStatus];
}

- (IBAction) consumeClick:(id)sender {
    [mpd consume];
    [self updateStatus];
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
    MSCStatus* status = [mpd status];
    [statusField setTitle: status.description];
    
    if (status.repeat) {
        repeatMode.title = @"RP";
    } else {
        repeatMode.title = @"rp";
    }
    if (status.random) {
        randomMode.title = @"RN";
    } else {
        randomMode.title = @"rn";
    }
    if (status.single) {
        singleMode.title = @"SI";
    } else {
        singleMode.title = @"si";
    }
    if (status.consume) {
        consumeMode.title = @"CN";
    } else {
        consumeMode.title = @"cn";
    }
}

- (MSCDir*) currentDirectory {
    return [self.directories objectAtIndex: self.directoriesController.selectionIndex];
}

- (NSString*) currentDirectoryPath {
    return [[self currentDirectory] path];
}

- (MSCSong*) currentSong {
//    return self.songsController.selection;
    return [self.songs objectAtIndex: self.songsController.selectionIndex];
}

- (NSString*) currentSongIndex {
    return [[self currentSong] position];
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

// MSCSongsNavigating
// ==================

- (void) playSong {
    [self playClick:nil];
}

@end
