//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@protocol ADRSearchScreenViewModelProtocol <NSObject>

@property (nonatomic, copy, readonly, nullable) NSString *searchTextFieldPlaceholder;
@property (nonatomic, copy, readonly, nullable) NSString *searchButtonTitle;
@property (nonatomic, copy, readonly, nullable) NSString *historyButtonTitle;

@property (nonatomic, assign, readonly) BOOL historyButtonEnable;
@property (nonatomic, assign, readonly) BOOL historyButtonVisiable;

@property (nonatomic, strong, readonly, nonnull) UIColor *backgroundColor;

@end