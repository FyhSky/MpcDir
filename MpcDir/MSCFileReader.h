//
//  MSCFileReader.h
//  MpcDir
//
//  Created by Никита Б. Зуев on 06.11.12.
//  Copyright (c) 2012 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCFileReader : NSObject
{
    NSString * filePath;
    
    NSFileHandle * fileHandle;
    
    unsigned long long currentOffset;
    unsigned long long totalFileLength;
    
    NSString * lineDelimiter;
    NSUInteger chunkSize;
}

@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithFileHandle:(NSFileHandle*)handle;
- (id) initWithFilePath:(NSString *)aPath;

- (NSString *) readLine;
- (NSString *) readTrimmedLine;

- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL *))block;

@end
