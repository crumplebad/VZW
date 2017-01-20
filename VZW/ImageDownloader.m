//
//  ImageDownloader.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/20/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "DataModel.h"

@implementation ImageDownloader

/**
 * This method downloads images, save it in the cache and asisgns it to image view.
 */
- (void)loadimage:(UIImageView *)imageView  urlString:(NSString *)aUrlString{
    
    NSURL *aUrl = [[NSURL alloc]initWithString:aUrlString];
    imageView.image = [UIImage imageNamed:@"placeholderImage.png"];
    [[[NSURLSession sharedSession] dataTaskWithURL:aUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            NSLog(@"%@", error.description);
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[DataModel model] cachedThumbnails]setObject:image forKey:aUrl];
                imageView.image = image;
            });
        }
    }] resume];
}

@end
