//
// Created by dmitrii.aitov@philips.com on 16/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ADRSearchHistoryTableCellViewModelProtocol;

///Search history table cell
@interface ADRSearchHistoryTableCell : UITableViewCell

///View model of history cell
@property (nonatomic, strong, readwrite, nonnull) NSObject<ADRSearchHistoryTableCellViewModelProtocol> *viewModel;

@end