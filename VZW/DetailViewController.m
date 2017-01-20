//
//  DetailViewController.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import "DetailViewController.h"
#import "VZW-Swift.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

/**
 * Configures the view with title and image.
 */
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.thumbnailViewModel) {
        NSString *name = [self.thumbnailViewModel nameText];
        self.detailDescriptionLabel.text = name;
        self.title = name;
        [self.dataManager setImageFor:self.detailImageView fromURLString:[self.thumbnailViewModel linkString]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(ThumbnailViewModel *)newThumbnailViewModel {
    if (_thumbnailViewModel != newThumbnailViewModel) {
        _thumbnailViewModel = newThumbnailViewModel;
        [self configureView];
    }
}

@end
