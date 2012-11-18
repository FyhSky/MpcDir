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
#import "NSArray+FP.h"
#import "MSCDir.h"

typedef id(^LineBlock)(NSString*);
typedef id(^DirBlock)(MSCDir*);

/// MPD output format string
FOUNDATION_EXPORT NSString *const MSC_MPD_FORMAT;

@interface MSCMpdClient : NSObject

/// Preferences are used to connect to mpd (@host, @port, @password etc...)
@property (readwrite,retain) MSCPreferences* preferences;

// Constructors
// =============

// Initialize client instance with preferences.
+ (id) mpd: (MSCPreferences*)prefs;

// Playlist management
// ===================

/// Add path to playlist.
///   Path should be relative to your musical directory
///   and can represent a single musical file or a whole directory.
- (void) add: (NSString*)path;

/// Clear playlist.
- (void) clear;

// Status detection
// ================

/// Get status from server.
- (MSCStatus*) status;

/// Get currently playing musical file.
- (NSString*) current;


// Playback control
// ================

/// Play musical file by index in playlist.
///   Index should be zero-based.
///   (MPD uses 1-bazed indices, so this function will
///   increment passed index before sending to server).
- (void) play: (NSString*)position;

/// Stop playing musical file.
///   Playlist position is not forgotten.
- (void) stop;

/// Pause current musical file.
- (void) pause;

/// Toggle pause/play mode.
- (void) toggle;

/// Play next musical file in playlist.
- (void) next;

/// Play previous musical file in playlist.
- (void) previous;


// Listings
// ========

/// List all musical files and directories in @dir.
///   @dir.path should be relative to your musical directory.
- (NSArray*) ls:(MSCDir*)dir;

/// List all musical files in @dir recursively.
///   @dir.path should be relative to your musical directory.
- (NSArray*) listall:(MSCDir*)dir;

/// List all musical files in your playlist.
///   Performs @block on every musical file and returns list of results.
- (NSArray*) playlist;



// Mode switches
// =============

/// Randomize playing inside playlist.
- (void) random;

/// Repeat one song (in single mode) or all playlist.
- (void) repeat;

/// Play song once (if repeat is off) or play it indefinitely.
- (void) single;

/// Delete song from playlist when going to next song.
- (void) consume;

@end
