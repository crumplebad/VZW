//
//  DataManager.h
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataManagerDelegate <NSObject>

- (void)dataChanged;

@end

@interface DataManager : NSObject

@property (nonatomic, weak) id<DataManagerDelegate> delegate;

- (NSArray *)getThumbnails;
- (void)setImageFor:(UIImageView *) imageView fromURLString:(NSString *)urlString;
- (void)sortBy:(NSString *)key andOrder:(BOOL)isAscending;

@end
