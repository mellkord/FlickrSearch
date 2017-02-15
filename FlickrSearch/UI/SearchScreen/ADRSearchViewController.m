//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchViewController.h"
#import "ADRSearchScreenViewModelProtocol.h"
#import "ADRSearchHistoryViewController.h"
#import "ADRSearchResultsViewController.h"
#import <Masonry/Masonry.h>


@interface ADRSearchViewController ()

@property (nonatomic, strong, readonly, nonnull) NSObject <ADRSearchScreenViewModelProtocol> *viewModel;

@property (nonatomic, strong, readonly, nonnull) UITextField *searchTextField;
@property (nonatomic, strong, readonly, nonnull) UIButton *searchButton;
@property (nonatomic, strong, readonly, nonnull) UIButton *historyButton;

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
    self.navigationController.navigationBarHidden = YES;

    _searchTextField = [[UITextField alloc] init];
    self.searchTextField.placeholder = self.viewModel.searchTextFieldPlaceholder;
    self.searchTextField.layer.borderColor = UIColor.blackColor.CGColor;
    self.searchTextField.layer.borderWidth = 2.0f;
    [self.view addSubview:self.searchTextField];

    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.searchButton setTitle:self.viewModel.searchButtonTitle forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.layer.borderColor = UIColor.blueColor.CGColor;
    self.searchButton.layer.borderWidth = 2.0f;
    [self.view addSubview:self.searchButton];

    _historyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.historyButton setTitle:self.viewModel.searchButtonTitle forState:UIControlStateNormal];
    [self.historyButton addTarget:self action:@selector(historyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.historyButton.layer.borderColor = UIColor.blueColor.CGColor;
    self.historyButton.layer.borderWidth = 2.0f;
    self.historyButton.enabled = self.viewModel.historyButtonEnable;
    self.historyButton.hidden = !self.viewModel.historyButtonVisiable;
    [self.view addSubview:self.historyButton];
}

- (void)setupAccessibilityIdentifiers
{
    self.view.accessibilityIdentifier = @"search_screen_view";
    self.searchTextField.accessibilityIdentifier = @"search_screen_search_text_field";
    self.searchButton.accessibilityIdentifier = @"search_screen_search_button";
    self.historyButton.accessibilityIdentifier = @"search_screen_history_button";
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
}

- (void)historyButtonClicked
{
    ADRSearchHistoryViewController *searchHistoryViewController = [[ADRSearchHistoryViewController alloc] init];
    [self.navigationController pushViewController:searchHistoryViewController animated:YES];
}

- (void)searchButtonClicked
{
    ///TODO Add search to local storage

    ADRSearchResultsViewController *searchResultsViewController = [[ADRSearchResultsViewController alloc] init];
    [self.navigationController pushViewController:searchResultsViewController animated:YES];
}

@end
