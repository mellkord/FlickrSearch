//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchResultsImageCell.h"
#import "ADRSearchResultsImageCellViewModelProtocol.h"
#import <Masonry/Masonry.h>

//TODO move magic numbers to constants
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
    self.backgroundColor = UIColor.lightGrayColor; //self.viewModel.backgroundColor;

    _imageView = [[UIImageView alloc] init];
    self.imageView.layer.borderColor = UIColor.blackColor.CGColor;
    self.imageView.layer.borderWidth = 2.0f;
    [self addSubview:self.imageView];

    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)setupConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.leading.equalTo(self).offset(5);
        make.trailing.equalTo(self).offset(-5);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.leading.equalTo(self.imageView);
        make.trailing.equalTo(self.imageView);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@20);
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