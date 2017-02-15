//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRSearchResultsViewController.h"
#import "ADRSearchResultsScreenViewModelProtocol.h"
#import "ADRSearchResultsImageCell.h"
#import "ADRSearchResultsLoadingCell.h"

static NSString * const kImageCellReuseIdentifier = @"ADRSearchResultsImageCell";
static NSString * const kLoadingCellReuseIdentifier = @"ADRSearchResultsLoadingCell";

@interface ADRSearchResultsViewController ()

@property (nonatomic, strong, readonly, nonnull) NSObject<ADRSearchResultsScreenViewModelProtocol> *viewModel;

@end

@implementation ADRSearchResultsViewController

- (nullable instancetype)initWithViewModel:(nonnull NSObject<ADRSearchResultsScreenViewModelProtocol> *)viewModel;
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(90, 125);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self = [super initWithCollectionViewLayout:flowLayout];

    if (self)
    {
        _viewModel = viewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel.collectionView = self.collectionView;
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);

    [self.collectionView registerClass:[ADRSearchResultsImageCell class] forCellWithReuseIdentifier:kImageCellReuseIdentifier];
    [self.collectionView registerClass:[ADRSearchResultsLoadingCell class] forCellWithReuseIdentifier:kLoadingCellReuseIdentifier];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.photosCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.viewModel.photosCount)
    {
        ADRSearchResultsImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCellReuseIdentifier forIndexPath:indexPath];
        return imageCell;
    }
    else
    {
        ADRSearchResultsLoadingCell *loadingCell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoadingCellReuseIdentifier forIndexPath:indexPath];
        return loadingCell;
    }
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<ADRSearchResultsImageCellViewModelProtocol> *imageCellModel = [self.viewModel modelForImageCellAtIndex:(NSUInteger)indexPath.row];

    if (imageCellModel)
    {
        ADRSearchResultsImageCell *imageCell = (ADRSearchResultsImageCell *)cell;
        imageCell.viewModel = imageCellModel;
    }
    else
    {
        ADRSearchResultsLoadingCell *loadingCell = (ADRSearchResultsLoadingCell *)cell;
        loadingCell.viewModel = [self.viewModel modelForLoadingCell];
    }
}


@end