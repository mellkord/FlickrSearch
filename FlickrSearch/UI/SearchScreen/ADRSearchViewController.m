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
#import "ADRNetworkClient.h"
#import <Masonry/Masonry.h>


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
    self.searchTextField.layer.borderColor = [UIColor colorWithRed:1.0f green:0.0f blue:132.0f/255.0f alpha:1.0f].CGColor;
    self.searchTextField.layer.borderWidth = 2.0f;
    self.searchTextField.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.75];
    [self.view addSubview:self.searchTextField];

    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.searchButton setTitle:self.viewModel.searchButtonTitle forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.layer.borderColor = [UIColor colorWithRed:0.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f].CGColor;
    self.searchButton.layer.borderWidth = 2.0f;
    self.searchButton.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.75];
    [self.view addSubview:self.searchButton];

    _historyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.historyButton setTitle:self.viewModel.searchButtonTitle forState:UIControlStateNormal];
    [self.historyButton addTarget:self action:@selector(historyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.historyButton.layer.borderColor = [UIColor colorWithRed:0.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f].CGColor;
    self.historyButton.layer.borderWidth = 2.0f;
    self.historyButton.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.75];
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
        make.top.equalTo(self.view).offset(120);
        make.leading.equalTo(self.view).offset(30);
        make.trailing.equalTo(self.view).offset(-30);
        make.height.equalTo(@40);
    }];

    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchTextField.mas_bottom).offset(20);
        make.leading.equalTo(self.searchTextField);
        make.trailing.equalTo(self.searchTextField);
        make.height.equalTo(@40);
    }];

    [self.historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchButton.mas_bottom).offset(20);
        make.leading.equalTo(self.searchTextField);
        make.trailing.equalTo(self.searchTextField);
        make.height.equalTo(@40);
    }];

    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.historyButton.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@256);
        make.height.equalTo(@256);
    }];

    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)historyButtonClicked
{
    ADRSearchHistoryViewController *searchHistoryViewController = [[ADRSearchHistoryViewController alloc] init];
    [self.navigationController pushViewController:searchHistoryViewController animated:YES];
}

- (void)searchButtonClicked
{
    if (!self.searchTextField.text || [self.searchTextField.text isEqualToString:@""])
    {
        return;
    }

    ///TODO Add search to local storage
    ADRFlickrNetworkService *flickrNetworkService = [[ADRFlickrNetworkService alloc] initWithAPIKey:@"665d363377bed56ced37a627947ebc56" networkClient:[[ADRNetworkClient alloc] init]];
    ADRFlickrSearchPhotoStorage *photoStorage = [[ADRFlickrSearchPhotoStorage alloc] initWithSearchString:self.searchTextField.text flickrService:flickrNetworkService delegate:nil];
    ADRFlickrSearchResultsViewModel *searchResultsViewModel = [[ADRFlickrSearchResultsViewModel alloc] initWithSearchString:self.searchTextField.text photoStorage:photoStorage];
    photoStorage.delegate = searchResultsViewModel;
    ADRSearchResultsViewController *searchResultsViewController = [[ADRSearchResultsViewController alloc] initWithViewModel:searchResultsViewModel];
    [self.navigationController pushViewController:searchResultsViewController animated:YES];
}

@end
