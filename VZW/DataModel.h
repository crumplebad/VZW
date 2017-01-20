//
//  DataModel.h
//  VZW
//
//  Created by Gaonkar, Jay  on 1/20/17.
//  Copyright © 2017 iJay. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) NSCache *cachedThumbnails;

+ (DataModel *)model;

@end
