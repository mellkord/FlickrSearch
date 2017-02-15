//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import <Foundation/Foundation.h>

///Search results loading cell view model
@protocol ADRSearchResultsLoadingCellViewModelProtocol <NSObject>

///This property shows if we are loading or not
@property (nonatomic, assign, readonly, getter=isLoading) BOOL loading;

///Error message if loading ends unsuccessfully
@property (nonatomic, copy, readonly, nullable) NSString *errorMessage;

@end