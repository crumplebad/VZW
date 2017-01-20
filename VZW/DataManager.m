//
//  DataManager.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

/**
 * This DataMaager class does NOT store any data but abstracts the data soure to the view controllers. 
 * It gets data from diffrent sources, DataModel(memory), DataStore(Persistent Storage), ImageDownloader(Network)
 */

#import "DataManager.h"
#import "DataModel.h"
#import "DataStore.h"
#import "VZW-Swift.h"
#import "ImageDownloader.h"

@implementation DataManager

- (id)init {
    if (self = [super init]) {
        [DataModel model].thumbnails = [[DataStore new] getDataFromFile];
    }
    
    return self;
}

- (void)setImageFor:(UIImageView *) imageView fromURLString:(NSString *)urlString {
    UIImage *anImage = [[[DataModel model] cachedThumbnails] objectForKey:urlString];
    if (anImage) {
        imageView.image = anImage;
    } else {
        [[ImageDownloader new] loadimage:imageView urlString:urlString];
    }
}

- (NSArray *)getThumbnails {
    return [[DataModel model] thumbnails];
}

- (void)sortBy:(NSString *)key andOrder:(BOOL)isAscending {

    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:isAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [DataModel model].thumbnails = [[DataModel model].thumbnails sortedArrayUsingDescriptors:sortDescriptors];
    [self.delegate dataChanged];
}

@end
