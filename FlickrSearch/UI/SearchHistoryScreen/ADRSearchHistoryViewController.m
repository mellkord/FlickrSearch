//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchHistoryViewController.h"
#import "ADRSearchHistoryScreenViewModelProtocol.h"
#import "ADRSearchHistoryStorage.h"
#import "ADRFlickrSearchPhotoStorage.h"
#import "ADRFlickrSearchResultsViewModel.h"
#import "ADRSearchResultsViewController.h"
#import "ADRSearchHistoryItem.h"
#import "AppDelegate.h"
#import "ADRSearchHistoryTableCell.h"
#import "ADRSearchHistoryTableCellViewModelProtocol.h"

static NSString * const kHistoryCellReuseIdentifier = @"ADRSearchHistoryCell";

static const float kHistoryCellHeight = 60.0f;

@interface ADRSearchHistoryViewController ()

@property (nonatomic, strong, readonly, nonnull) NSObject <ADRSearchHistoryScreenViewModelProtocol> *viewModel;

@end

@implementation ADRSearchHistoryViewController

- (instancetype)initWithViewModel:(NSObject <ADRSearchHistoryScreenViewModelProtocol> *)viewModel
{
    self = [super init];

    if (self)
    {
        _viewModel = viewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[ADRSearchHistoryTableCell class] forCellReuseIdentifier:kHistoryCellReuseIdentifier];

    self.title = self.viewModel.screenTitle;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.historyCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHistoryCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADRSearchHistoryTableCell *historyCell = (ADRSearchHistoryTableCell *)cell;
    historyCell.viewModel = [self.viewModel modelForHistoryCellAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [appDelegate.historyStorage addSearchHistory:[[ADRSearchHistoryItem alloc] initWithSearchString:[self.viewModel modelForHistoryCellAtIndex:indexPath.row].searchString searchDate:[NSDate date]]];

    ADRFlickrSearchPhotoStorage *photoStorage = [[ADRFlickrSearchPhotoStorage alloc] initWithSearchString:[self.viewModel modelForHistoryCellAtIndex:indexPath.row].searchString flickrService:appDelegate.flickrNetworkService delegate:nil];
    ADRFlickrSearchResultsViewModel *searchResultsViewModel = [[ADRFlickrSearchResultsViewModel alloc] initWithSearchString:[self.viewModel modelForHistoryCellAtIndex:indexPath.row].searchString photoStorage:photoStorage];
    ADRSearchResultsViewController *searchResultsViewController = [[ADRSearchResultsViewController alloc] initWithViewModel:searchResultsViewModel];
    [self.navigationController pushViewController:searchResultsViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHistoryCellHeight;
}

@end
