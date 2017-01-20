//
//  DetailViewController.h
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@class ThumbnailViewModel;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ThumbnailViewModel *thumbnailViewModel;
@property DataManager *dataManager;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

