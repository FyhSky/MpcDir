//
//  MSCPreferences.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 10.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

// Path to save preferences of this application
FOUNDATION_EXPORT NSString *const MSC_PREFERENCES_PATH;

// ******************************
// Preferences of client software
// ******************************
@interface MSCPreferences : NSObject
{
    NSUserDefaults* _prefs;
}

// Full path to mpc client
- (NSString*) client;

// IP-address or domain name of server where mpd is installed
- (NSString*) host;

// Port on which mpd listens (nil for default)
- (NSString*) port;

// Password to access mpd (nil for no password)
- (NSString*) password;

- (void) reset;

@end
