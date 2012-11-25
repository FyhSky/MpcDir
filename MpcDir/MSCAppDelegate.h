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
#import "MSCDirectoriesNavigating.h"
#import "MSCSongsNavigating.h"
#import "MSCSong.h"


@interface MSCAppDelegate : NSObject <NSApplicationDelegate, MSCDirectoriesNavigating>
{
    MSCMpdClient*   mpd;
    NSTimer*        statusTimer;
    
    IBOutlet NSTextField*  patternField;
    IBOutlet NSButton*     statusField;
    
    IBOutlet NSMenu* fileMenu;
    IBOutlet NSMenu* formatMenu;
    IBOutlet NSMenu* viewMenu;
    
    IBOutlet NSTableView* songsView;
    
    IBOutlet NSButton* repeatMode;
    IBOutlet NSButton* randomMode;
    IBOutlet NSButton* singleMode;
    IBOutlet NSButton* consumeMode;
    
    IBOutlet NSProgressIndicator* connectingLevel;
}

@property BOOL isInPlaylist;

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet NSWindow* preferencesWindow;
@property (assign) IBOutlet NSWindow* connectingWindow;

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
- (IBAction) pauseClick:(id)sender;

// Listings
// ========
- (IBAction) searchClick:(id)sender;
- (IBAction) listClick:(id)sender;
- (IBAction) playlistClick:(id)sender;

// Mode switches
// =============
- (IBAction) randomClick:(id)sender;
- (IBAction) repeatClick:(id)sender;
- (IBAction) singleClick:(id)sender;
- (IBAction) consumeClick:(id)sender;

// Preferences actions
// ===================
- (IBAction) showPreferences:(id)sender;
- (IBAction) savePreferencesClick:(id)sender;
- (IBAction) resetPreferencesClick:(id)sender;

@end
