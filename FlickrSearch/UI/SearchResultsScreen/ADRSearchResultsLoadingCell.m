//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchResultsLoadingCell.h"
#import "ADRSearchResultsLoadingCellViewModelProtocol.h"
#import <Masonry/Masonry.h>

static const int kImageEdgeMargins = 20;
static const int kErrorLeftRightMargins = 10;
static const int kErrorHeight = 20;

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
    self.backgroundColor = UIColor.lightGrayColor;

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
        make.edges.equalTo(self).offset(kImageEdgeMargins);
    }];

    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.leading.equalTo(self).offset(kErrorLeftRightMargins);
        make.trailing.equalTo(self).offset(-kErrorLeftRightMargins);
        make.height.equalTo(@(kErrorHeight));
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