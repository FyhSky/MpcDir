//
//  MSCMpdClient.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 29.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCPreferences.h"
#import "MSCStatus.h"

@interface MSCMpdClient : NSObject

@property (readwrite,retain) MSCPreferences* preferences;

// Counstructors
// =============

// Initialize client instance with preferences.
+ (id) mpd: (MSCPreferences*)prefs;

// Playlist management
// ===================

// Add path to playlist.
//   Path should be relative to your musical directory
//   and can represent a single musical file or a whole directory.
- (void) add: (NSString*)path;

// Clear playlist.
- (void) clear;

// Status detection
// ================

// Get status from server.
- (MSCStatus*) status;

// Get currently playing musical file.
- (NSString*) current;


// Playback control
// ================

// Play musical file by index in playlist.
//   Index should be zero-based.
//   (MPD uses 1-bazed indices, so this function will
//   increment passed index before sending to server).
- (void) play: (NSUInteger)index;

// Stop playing musical file.
//   Playlist position is not forgotten.
- (void) stop;

// Pause/unpause current musical file.
- (void) pause;

// Play next musical file in playlist.
- (void) next;

// Play previous musical file in playlist.
- (void) previous;


// Listings
// ========

// List all musical files and directories in path.
//   Path should be relative to your musical directory.
- (NSArray*) ls: (NSString*)path;

// List all musical files in path recursively.
//   Path should be relative to your musical directory.
- (NSArray*) listall: (NSString*)path;

// List all musical files in your playlist.
- (NSArray*) playlist;



// Mode switches
// =============

// Randomize playing inside playlist.
- (void) random;

// Repeat one song (in single mode) or all playlist.
- (void) repeat;

// Play song once (if repeat is off) or play it indefinitely.
- (void) single;

// Delete song from playlist when going to next song.
- (void) consume;

@end
