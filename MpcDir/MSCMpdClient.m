//
//  MSCMpdClient.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 29.10.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCMpdClient.h"

@implementation MSCMpdClient

@synthesize preferences;

// Counstructors
// =============

+ (id) mpd: (MSCPreferences*)prefs
{
    MSCMpdClient* client = [[MSCMpdClient alloc] init];
    if (client == nil) {
        return nil;
    }
    
    client.preferences = prefs;
    return client;
}

// Playlist management
// ===================

- (void) add: (NSString*)path {
    [self mpcrun: @"add", path, nil];
}

- (void) clear {
    [self mpcrun: @"clear", nil];
}

// Status detection
// ================

- (MSCStatus*) status {
    return [MSCStatus statusWithArray: [self mpcquery:@"status", nil]];
}

- (NSString*) current {
    return [self mpcrun: @"current", nil];
}

// Playback control
// ================

- (void) play: (NSUInteger)index {
    [self mpcrun: @"play", [NSString stringWithFormat: @"%ld", index + 1], nil];
}

- (void) stop {
    [self mpcrun: @"stop", nil];
}

- (void) pause {
    [self mpcrun: @"pause", nil];
}

- (void) next {
    [self mpcrun: @"next", nil];
}

- (void) previous {
    [self mpcrun: @"prev", nil];
}

// Listings
// ========

- (NSArray*) ls:(NSString*)path {
    return [self mpcquery: @"ls", path, nil];
}

- (NSArray*) listall:(NSString*)path {
    return [self mpcquery: @"listall", path, nil];
}

- (NSArray*) playlist {
    return [self mpcquery: @"playlist", nil];
}

// Mode switches
// =============

- (void) random {
    [self mpcrun:@"random", nil];
}

- (void) repeat {
    [self mpcrun:@"repeat", nil];
}

- (void) single {
    [self mpcrun:@"single", nil];
}

- (void) consume {
    [self mpcrun:@"consume", nil];
}

// Helper methods
// ==============

- (NSArray*)mpcquery:(id)arg, ...
{
    if (arg == nil) {
        return nil;
    }
    
    NSMutableArray* args = [NSMutableArray array];
    
    [args addObject:@"-h"];
    [args addObject:preferences.host];
    
    if (preferences.port) {
        [args addObject:@"-p"];
        [args addObject:preferences.port];
    }
    
    if (preferences.password) {
        [args addObject:@"-P"];
        [args addObject:preferences.password];
    }
    
    [args addObject:arg];
    
    id currentArg;
    va_list argumentList;
    va_start(argumentList, arg);
    while((currentArg = va_arg(argumentList, id))) {
        [args addObject: currentArg];
    }
    va_end(argumentList);
    
    NSTask* task = [[NSTask alloc] init];
    NSPipe* tout = [NSPipe pipe];
    
    NSLog(@"mpcrun: %@", args);
    
    [task setLaunchPath: preferences.client];
    [task setArguments: args];
    [task setStandardOutput: tout];
    
    [task launch];
    
    NSData*   data  = [[tout fileHandleForReading] readDataToEndOfFile];
    NSString* str   = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray* result = [str componentsSeparatedByString:@"\n"];
    
    [task waitUntilExit];
    
    return result;
}

- (NSString*)mpcrun:(id)arg, ...
{
    if (arg == nil) {
        return nil;
    }
    
    NSMutableArray* args = [NSMutableArray array];
    
    [args addObject:@"-h"];
    [args addObject:preferences.host];
    
    if (preferences.port) {
        [args addObject:@"-p"];
        [args addObject:preferences.port];
    }
    
    if (preferences.password) {
        [args addObject:@"-P"];
        [args addObject:preferences.password];
    }
    
    [args addObject:arg];
    
    id currentArg;
    va_list argumentList;
    va_start(argumentList, arg);
    while((currentArg = va_arg(argumentList, id))) {
        [args addObject: currentArg];
    }
    va_end(argumentList);
    
    NSTask* task = [[NSTask alloc] init];
    NSPipe* tout = [NSPipe pipe];
    
    NSLog(@"mpcrun: %@", args);
    
    [task setLaunchPath: preferences.client];
    [task setArguments: args];
    [task setStandardOutput: tout];
    
    [task launch];
        
    NSData*   data = [[tout fileHandleForReading] readDataToEndOfFile];
    NSString* str  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [task waitUntilExit];
    
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end