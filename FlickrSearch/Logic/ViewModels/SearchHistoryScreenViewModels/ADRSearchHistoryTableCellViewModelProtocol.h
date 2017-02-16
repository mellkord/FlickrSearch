//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

///Search history cell view model protocol
@protocol ADRSearchHistoryTableCellViewModelProtocol

///Search string
@property (nonatomic, copy, readonly, nonnull) NSString *searchString;

///Search date string
@property (nonatomic, copy, readonly, nonnull) NSString *dateString;

///Cell background color
@property (nonatomic, strong, readonly, nonnull) UIColor *backgroundColor;

@end