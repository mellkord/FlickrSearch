//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchViewController.h"
#import "ADRSearchScreenViewModelProtocol.h"
#import "ADRSearchHistoryViewController.h"
#import "ADRSearchResultsViewController.h"
#import "ADRFlickrSearchResultsViewModel.h"
#import "ADRFlickrSearchPhotoStorage.h"
#import "ADRFlickrNetworkService.h"
#import "ADRSearchHistoryStorage.h"
#import "ADRSearchHistoryItem.h"
#import "ADRFlickrSearchHistoryViewModel.h"
#import "AppDelegate.h"
#import <Masonry/Masonry.h>


static const float kElementsAlpha = 0.75f;
static const float kElementsBorderWidth = 2.0f;
static const int kElementsHeight = 40;
static const int kLeftRightMargin = 30;
static const int kTopMargin = 120;
static const int kBottomMargin = 20;
static const int kLogoWidthHeight = 256;

@interface ADRSearchViewController ()

@property (nonatomic, strong, readonly, nonnull) NSObject <ADRSearchScreenViewModelProtocol> *viewModel;

@property (nonatomic, strong, readonly, nonnull) UITextField *searchTextField;
@property (nonatomic, strong, readonly, nonnull) UIButton *searchButton;
@property (nonatomic, strong, readonly, nonnull) UIButton *historyButton;

@property (nonatomic, strong, readonly, nonnull) UIImageView *backgroundImageView;
@property (nonatomic, strong, readonly, nonnull) UIImageView *logoImageView;

@end

@implementation ADRSearchViewController

- (instancetype)initWithViewModel:(NSObject <ADRSearchScreenViewModelProtocol> *)viewModel
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

    [self setupSubviews];
    [self setupConstraints];
    [self setupAccessibilityIdentifiers];
}

- (void)setupSubviews
{
    self.view.backgroundColor = self.viewModel.backgroundColor;

    _searchTextField = [[UITextField alloc] init];
    self.searchTextField.placeholder = self.viewModel.searchTextFieldPlaceholder;
    self.searchTextField.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:132.0f/255.0f alpha:1.0f].CGColor;
    self.searchTextField.layer.borderWidth = kElementsBorderWidth;
    self.searchTextField.textAlignment = NSTextAlignmentCenter;
    self.searchTextField.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:kElementsAlpha];
    [self.view addSubview:self.searchTextField];

    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.searchButton setTitle:self.viewModel.searchButtonTitle forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.layer.borderColor = [UIColor colorWithRed:0.0f/255.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f].CGColor;
    self.searchButton.layer.borderWidth = kElementsBorderWidth;
    self.searchButton.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:kElementsAlpha];
    [self.view addSubview:self.searchButton];

    _historyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.historyButton setTitle:self.viewModel.historyButtonTitle forState:UIControlStateNormal];
    [self.historyButton addTarget:self action:@selector(historyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.historyButton.layer.borderColor = [UIColor colorWithRed:0.0f/255.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f].CGColor;
    self.historyButton.layer.borderWidth = kElementsBorderWidth;
    self.historyButton.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:kElementsAlpha];
    self.historyButton.enabled = self.viewModel.historyButtonEnable;
    self.historyButton.hidden = !self.viewModel.historyButtonVisible;
    [self.view addSubview:self.historyButton];

    _backgroundImageView = [[UIImageView alloc] initWithImage:self.viewModel.backgroundImage];
    self.backgroundImageView.backgroundColor = UIColor.clearColor;
    [self.view insertSubview:self.backgroundImageView atIndex:0];

    _logoImageView = [[UIImageView alloc] initWithImage:self.viewModel.logoImage];
    self.logoImageView.backgroundColor = UIColor.clearColor;
    [self.view insertSubview:self.logoImageView atIndex:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.historyButton.enabled = self.viewModel.historyButtonEnable;
    self.navigationController.navigationBarHidden = YES;
}

- (void)setupAccessibilityIdentifiers
{
    self.view.accessibilityIdentifier = @"search_screen_view";
    self.searchTextField.accessibilityIdentifier = @"search_screen_search_text_field";
    self.searchButton.accessibilityIdentifier = @"search_screen_search_button";
    self.historyButton.accessibilityIdentifier = @"search_screen_history_button";
    self.backgroundImageView.accessibilityIdentifier = @"search_screen_background_image";
    self.logoImageView.accessibilityIdentifier = @"search_screen_logo_image";
}

- (void)setupConstraints
{
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kTopMargin);
        make.leading.equalTo(self.view).offset(kLeftRightMargin);
        make.trailing.equalTo(self.view).offset(-kLeftRightMargin);
        make.height.equalTo(@(kElementsHeight));
    }];

    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextField.mas_bottom).offset(kBottomMargin);
        make.leading.equalTo(self.searchTextField);
        make.trailing.equalTo(self.searchTextField);
        make.height.equalTo(@(kElementsHeight));
    }];

    [self.historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom).offset(kBottomMargin);
        make.leading.equalTo(self.searchTextField);
        make.trailing.equalTo(self.searchTextField);
        make.height.equalTo(@(kElementsHeight));
    }];

    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.historyButton.mas_bottom).offset(kBottomMargin);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kLogoWidthHeight));
        make.height.equalTo(@(kLogoWidthHeight));
    }];

    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)historyButtonClicked
{
    ADRFlickrSearchHistoryViewModel *searchHistoryViewModel = [[ADRFlickrSearchHistoryViewModel alloc] init];
    ADRSearchHistoryViewController *searchHistoryViewController = [[ADRSearchHistoryViewController alloc] initWithViewModel:searchHistoryViewModel];
    [self.navigationController pushViewController:searchHistoryViewController animated:YES];
}

- (void)searchButtonClicked
{
    if (!self.searchTextField.text || [self.searchTextField.text isEqualToString:@""])
    {
        return;
    }

    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [appDelegate.historyStorage addSearchHistory:[[ADRSearchHistoryItem alloc] initWithSearchString:self.searchTextField.text searchDate:[NSDate date]]];

    ADRFlickrSearchPhotoStorage *photoStorage = [[ADRFlickrSearchPhotoStorage alloc] initWithSearchString:self.searchTextField.text flickrService:appDelegate.flickrNetworkService delegate:nil];
    ADRFlickrSearchResultsViewModel *searchResultsViewModel = [[ADRFlickrSearchResultsViewModel alloc] initWithSearchString:self.searchTextField.text photoStorage:photoStorage];
    ADRSearchResultsViewController *searchResultsViewController = [[ADRSearchResultsViewController alloc] initWithViewModel:searchResultsViewModel];
    [self.navigationController pushViewController:searchResultsViewController animated:YES];
}

@end
