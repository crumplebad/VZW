//
//  DataModel.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/20/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+ (DataModel *)model {
    static DataModel *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] init];
    });
    return store;
}

@end
