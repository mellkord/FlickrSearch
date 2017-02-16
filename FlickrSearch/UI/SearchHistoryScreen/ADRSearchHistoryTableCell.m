//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchHistoryTableCell.h"
#import "ADRSearchHistoryTableCellViewModelProtocol.h"
#import <Masonry/Masonry.h>

static const int kSearchStringFontSize = 18;
static const int kDateStringSearchSize = 11;
static const int kTopElementsMargin = 10;
static const int kLeftRightElementsMargin = 20;

@interface ADRSearchHistoryTableCell ()

@property (nonatomic, strong, readonly, nonnull) UILabel *titleLabel;
@property (nonatomic, strong, readonly, nonnull) UILabel *dateLabel;

@end

@implementation ADRSearchHistoryTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

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
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:kSearchStringFontSize weight:300];
    self.titleLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [self addSubview:self.titleLabel];

    _dateLabel = [[UILabel alloc] init];
    self.dateLabel.numberOfLines = 1;
    self.dateLabel.textAlignment = NSTextAlignmentLeft;
    self.dateLabel.font = [UIFont systemFontOfSize:kDateStringSearchSize];
    self.dateLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:99.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [self addSubview:self.dateLabel];
}

- (void)setupConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kTopElementsMargin);
        make.leading.equalTo(self).offset(kLeftRightElementsMargin);
        make.trailing.equalTo(self).offset(-kLeftRightElementsMargin);
        make.height.equalTo(@(kLeftRightElementsMargin));
    }];

    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kTopElementsMargin);
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.titleLabel);
        make.height.equalTo(@(kDateStringSearchSize));
    }];
}

- (void)setupAccessibilityIdentifiers
{

}

- (void)setViewModel:(NSObject <ADRSearchHistoryTableCellViewModelProtocol> *)viewModel
{
    _viewModel = viewModel;

    self.titleLabel.text = _viewModel.searchString;
    self.dateLabel.text = _viewModel.dateString;
    self.backgroundColor = _viewModel.backgroundColor;
}

@end