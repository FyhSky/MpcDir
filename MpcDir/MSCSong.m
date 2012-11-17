//
//  MSCSong.m
//  MpcDir
//
//  Created by Никита Б. Зуев on 17.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import "MSCSong.h"

@implementation MSCSong

@synthesize data;
@synthesize position;
@synthesize artist;
@synthesize title;
@synthesize album;
@synthesize year;

+ (MSCSong*) songWithData:(NSString *)data {
    MSCSong* song = [[MSCSong alloc] init];
    if (song) {
        song.data = data;
        NSArray* tags = [data componentsSeparatedByString:@"@@@"];
        if (tags.count > 3) {
            song.position = tags[0];
            song.artist = tags[1];
            song.title = tags[2];
            song.album = tags[3];
        }
    }
    return song;
}

- (NSUInteger) findMeIn:(NSArray*) songs {
    return [songs indexOfObject: self];
}

- (BOOL) isEqual:(id)other {
    if ([other isKindOfClass:[MSCSong class]]) {
        return [[self data] isEqual: [other data]];
    } else if ([other isKindOfClass:[NSString class]]) {
        return [[self data] isEqual: other];
    } else {
        return NO;
    }
}

- (NSUInteger) hash {
    return [[self data] hash];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ - %@", self.artist, self.title];
}

@end
