//
//  MSCAppDelegate.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 28.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCMpdClient.h"
#import "MSCDir.h"
#import "MSCPreferences.h"
#import "NSArray+FP.h"

@interface MSCAppDelegate : NSObject <NSApplicationDelegate>
{
    BOOL            isInPlaylist;
    MSCMpdClient*   mpd;
    NSTimer*        statusTimer;
    
    IBOutlet NSTextField*  patternField;
    IBOutlet NSButton*     statusField;
    
    IBOutlet NSMenu* fileMenu;
    IBOutlet NSMenu* formatMenu;
    IBOutlet NSMenu* viewMenu;
    IBOutlet NSMenu* directoryMenu;
    
    IBOutlet NSTableView* songsView;
}

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet NSWindow* preferencesWindow;

@property (retain) NSArray* directories;
@property (assign) IBOutlet NSArrayController* directoriesController;

@property (retain) NSArray* songs;
@property (assign) IBOutlet NSArrayController* songsController;

@property (retain) MSCPreferences* preferences;

// Playlist management
// ===================
- (IBAction) addClick:(id)sender;
- (IBAction) clearClick:(id)sender;
- (IBAction) addDirToPlaylist:(id)sender;
- (IBAction) setDirAsPlaylist:(id)sender;

// Status detection
// ================
- (IBAction) statusClick:(id)sender;

// Playback control
// ================
- (IBAction) playClick:(id)sender;
- (IBAction) playPreviousClick:(id)sender;
- (IBAction) playNextClick:(id)sender;

// Listings
// ========
- (IBAction) searchClick:(id)sender;
- (IBAction) listClick:(id)sender;
- (IBAction) playlistClick:(id)sender;

// Preferences actions
// ===================
- (IBAction) showPreferences:(id)sender;
- (IBAction) savePreferencesClick:(id)sender;
- (IBAction) resetPreferencesClick:(id)sender;

@end
