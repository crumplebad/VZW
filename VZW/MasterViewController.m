//
//  MasterViewController.m
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DataManager.h"
#import "VZW-Swift.h"

NSString *const kTitleAscending = @"Title ^";
NSString *const kTitleDecending = @"Title V";
NSString *const kLinkAscending = @"Link ^";
NSString *const kLinkDecending = @"Link V";


@interface MasterViewController ()

@property DataManager *dataManager;
@property UIBarButtonItem *linkBarBtn;
@property UIBarButtonItem *titleBarBtn;

@end

@implementation MasterViewController

/**
 * In this delegate class, bar buttons are initiallized, search bar is setup, and DataManager is setup.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.linkBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"Link" style:UIBarButtonItemStylePlain target:self action:@selector(sortByLink:)];
    self.navigationItem.leftBarButtonItem = self.linkBarBtn;

    self.titleBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"Title" style:UIBarButtonItemStylePlain target:self action:@selector(sortByTitle:)];
    self.navigationItem.rightBarButtonItem = self.titleBarBtn;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self setupSearchController];
    self.dataManager = [DataManager new];
    self.dataManager.delegate = self;
}

/**
 * Setsup searchbar controller
 */
- (void)setupSearchController {
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.imageTableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchController.searchBar sizeToFit];
}

/**
 * This method called when tite bar button is tapped and sorts the data.
 */
- (IBAction)sortByTitle:(id)sender {
    if ([self.titleBarBtn.title isEqualToString:kTitleAscending]) {
        [self.dataManager sortBy:@"nameText" andOrder:NO];
        [self.titleBarBtn setTitle:kTitleDecending];
    } else {
        [self.dataManager sortBy:@"nameText" andOrder:YES];
        [self.titleBarBtn setTitle:kTitleAscending];
    }
    [self.linkBarBtn setTitle:@"Link"];
}

/**
 * This method called when link bar button is tapped and sorts the data.
 */
- (IBAction)sortByLink:(id)sender {
    if ([self.linkBarBtn.title isEqualToString:kLinkAscending]) {
        [self.dataManager sortBy:@"linkString" andOrder:NO];
        [self.linkBarBtn setTitle:kLinkDecending];
    } else {
        [self.dataManager sortBy:@"linkString" andOrder:YES];
        [self.linkBarBtn setTitle:kLinkAscending];
    }
    [self.titleBarBtn setTitle:@"Title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Manager Delegate

/**
 * This is delegate method called when data source is changed, used when sorting.
 */
- (void)dataChanged {
    [self.imageTableView reloadData];
}

#pragma mark - Segues

/**
 * Storyboard method used to naviagte to the detail view controller and also passed the selected item onto the view controller.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.imageTableView indexPathForSelectedRow];
        ThumbnailViewModel *thumbnail;
        if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString:@""]) {
            thumbnail = self.filterList[indexPath.row];
        } else {
            thumbnail = self.dataManager.getThumbnails[indexPath.row];
        }
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setThumbnailViewModel:thumbnail];
        [controller setDataManager:self.dataManager];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString:@""]) {
        return self.filterList.count;
    } else {
        return self.dataManager.getThumbnails.count;
    }
}

/**
 * TableView Delegate method, where cell is customized.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];
    ThumbnailViewModel *thumbnail;
    if (self.searchController.isActive && ![self.searchController.searchBar.text isEqualToString:@""]) {
        thumbnail = self.filterList[indexPath.row];
    } else {
        thumbnail = self.dataManager.getThumbnails[indexPath.row];
    }
    cell.titleLabel.text =  thumbnail.nameText;
    [self.dataManager setImageFor:cell.thumbnailImageView fromURLString:thumbnail.linkString];
    return cell;
}

#pragma SearchResult Update Delegate

/**
 * Search Delegate Method, where the data source is filtereed based on the search string.
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"nameText contains[c] %@",
                                    searchText];
    self.filterList = [self.dataManager.getThumbnails filteredArrayUsingPredicate:resultPredicate];
    [self.imageTableView reloadData];
}

#pragma SearchBar Delagate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

@end
