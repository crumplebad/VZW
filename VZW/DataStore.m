//
//  DataStore.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/20/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import "DataStore.h"
#import "VZW-Swift.h"

@implementation DataStore

/**
 * This method read teh JSON from the bundle and returns an array of ObjC/Swift objects.
 */
- (NSArray *)getDataFromFile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"json"];
    
    if (filePath) {
        //retrieve file content
        NSData *imagesData = [[NSData alloc] initWithContentsOfFile:filePath];
        
        //convert JSON NSData to a usable NSDictionary
        NSError *error;
        NSArray *images = [NSJSONSerialization JSONObjectWithData:imagesData
                                                          options:0
                                                            error:&error];
        
        if (error) {
            NSLog(@"Something went wrong! %@", error.localizedDescription);
        } else {
            NSLog(@"party info: %@", images);
            NSMutableArray *mutableArray = [NSMutableArray new];
            for (NSDictionary *aDict in images) {
                
                Thumbnail *thumbnail = [[Thumbnail alloc] initWithDictionary: aDict];
                ThumbnailViewModel *thumbnailViewModel = [[ThumbnailViewModel alloc] initWithThumbnail:thumbnail];
                [mutableArray addObject: thumbnailViewModel];
            }
            return [mutableArray copy];
        }
    }
    else {
        NSLog(@"Couldn't find file!");
    }
    return nil;
}

@end
