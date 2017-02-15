//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchResultsLoadingCell.h"
#import "ADRSearchResultsLoadingCellViewModelProtocol.h"
#import <Masonry/Masonry.h>

//TODO move magic numbers to constants
@interface ADRSearchResultsLoadingCell ()

@property (nonatomic, strong, readonly, nonnull) UIActivityIndicatorView *activityView;
@property (nonatomic, strong, readonly, nonnull) UILabel *errorLabel;

@end

@implementation ADRSearchResultsLoadingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        [self setupSubviews];
        [self setupConstraints];
        [self setupAccessibilityIdentifiers];
    }

    return self;
}

- (void)setupSubviews
{
    self.backgroundColor = UIColor.lightGrayColor; //self.viewModel.backgroundColor;

    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:self.activityView];

    _errorLabel = [[UILabel alloc] init];
    self.errorLabel.numberOfLines = 1;
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.errorLabel];
}

- (void)setupConstraints
{
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.edges.equalTo(self).offset(20);
    }];

    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.height.equalTo(@20);
    }];
}

- (void)setupAccessibilityIdentifiers
{

}

- (void)setViewModel:(NSObject <ADRSearchResultsLoadingCellViewModelProtocol> *)viewModel
{
    _viewModel = viewModel;

    self.errorLabel.text = _viewModel.errorMessage;
    self.activityView.hidden = !_viewModel.isLoading;
}


@end