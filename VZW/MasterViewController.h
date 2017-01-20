//
//  MasterViewController.h
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@class DetailViewController;

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, DataManagerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UITableView *imageTableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *filterList;


@end

