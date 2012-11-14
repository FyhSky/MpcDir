//
//  MSCPreferences.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 10.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCPreferences.h"

NSString *const MSC_PREFERENCES_PATH = @"~/Library/Preferences/ru.massoc.MpcDir.plist";

@implementation MSCPreferences

+ (id)preferences {
    return [[MSCPreferences alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        NSMutableDictionary* defaults = [NSMutableDictionary new];
        
        [defaults setObject:@"/opt/local/bin/mpc" forKey:@"client"];
        [defaults setObject:@"localhost"          forKey:@"host"];
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaults];
    }
    return self;
}

// Full path to mpc client
- (NSString*) client {
    return [_prefs valueForKey:@"client"];
}

// IP-address or domain name of server where mpd is installed
- (NSString*) host {
    return [_prefs valueForKey:@"host"];
}

// Port on which mpd listens (nil for default)
- (NSString*) port {
    return [_prefs valueForKey:@"port"];
}

// Password to access mpd (nil for no password)
- (NSString*) password {
    return [_prefs valueForKey:@"password"];
}


- (void) reset {
    [_prefs setObject:@"/opt/local/bin/mpc" forKey:@"client"];
    [_prefs setObject:@"localhost" forKey:@"host"];
    [_prefs setObject:nil forKey:@"port"];
    [_prefs setObject:nil forKey:@"password"];
}

@end
