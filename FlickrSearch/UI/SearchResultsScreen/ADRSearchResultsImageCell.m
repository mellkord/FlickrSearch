//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchResultsImageCell.h"
#import "ADRSearchResultsImageCellViewModelProtocol.h"
#import <Masonry/Masonry.h>

static const float kBorderWidth = 2.0f;
static const int kImageMargins = 5;
static const int kElementsSeparatorHeight = 5;
static const int kTitleHeight = 11;
static const float kCornerRadius = 2.0f;

@interface ADRSearchResultsImageCell ()

@property (nonatomic, strong, readonly, nonnull) UIImageView *imageView;
@property (nonatomic, strong, readonly, nonnull) UILabel *titleLabel;

@end

@implementation ADRSearchResultsImageCell

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
    self.layer.cornerRadius = kCornerRadius;

    _imageView = [[UIImageView alloc] init];
    self.imageView.layer.borderColor = UIColor.blackColor.CGColor;
    self.imageView.layer.borderWidth = kBorderWidth;
    [self addSubview:self.imageView];

    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:kTitleHeight];
    [self addSubview:self.titleLabel];
}

- (void)setupConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kImageMargins);
        make.leading.equalTo(self).offset(kImageMargins);
        make.trailing.equalTo(self).offset(-kImageMargins);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(kElementsSeparatorHeight);
        make.leading.equalTo(self.imageView);
        make.trailing.equalTo(self.imageView);
        make.bottom.equalTo(self).offset(-kElementsSeparatorHeight);
        make.height.equalTo(@(kTitleHeight));
    }];
}

- (void)setupAccessibilityIdentifiers
{

}

- (void)setViewModel:(NSObject <ADRSearchResultsImageCellViewModelProtocol> *)viewModel
{
    _viewModel = viewModel;

    self.imageView.image = _viewModel.image;
    self.titleLabel.text = _viewModel.title;
}

@end