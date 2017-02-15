//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIImage.h>

///Protocol for search screen view model
@protocol ADRSearchScreenViewModelProtocol <NSObject>

///Placeholder text for search text field
@property (nonatomic, copy, readonly, nullable) NSString *searchTextFieldPlaceholder;

///Search button title
@property (nonatomic, copy, readonly, nullable) NSString *searchButtonTitle;

///History button title
@property (nonatomic, copy, readonly, nullable) NSString *historyButtonTitle;

///Is history button enable
@property (nonatomic, assign, readonly) BOOL historyButtonEnable;

///Is history button visible
@property (nonatomic, assign, readonly) BOOL historyButtonVisible;

///Search screen background color
@property (nonatomic, strong, readonly, nonnull) UIColor *backgroundColor;

///Search screen background image
@property (nonatomic, strong, readonly, nonnull) UIImage *backgroundImage;

///Search screen logo
@property (nonatomic, strong, readonly, nonnull) UIImage *logoImage;

@end