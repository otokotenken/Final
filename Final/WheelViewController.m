//
//  WheelViewController.m
//  Final
//
//  Created by DetroitLabs on 7/14/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "WheelViewController.h"
#import "WheelCollectionViewCell.h"
#import "WheelCollectionViewLayout.h"
@import Firebase;

@interface WheelViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *iconsArray;
@property (nonatomic, strong) NSMutableArray * imageNamesArray;
@property FIRDatabaseReference *ref;

@end

@implementation WheelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    [self initImages];
    
    [self.collectionView registerClass:[WheelCollectionViewCell class] forCellWithReuseIdentifier:@"ItemIdentifier"];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0., 30.);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_iconsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WheelCollectionViewCell *cell = (WheelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ItemIdentifier" forIndexPath:indexPath];
    cell.imageView = self.iconsArray[indexPath.item];
    cell.imageName = self.imageNamesArray[indexPath.item];
    cell.layer.borderWidth = 5.0f;
    return cell;
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
//                        layout:(UICollectionViewLayout *)collectionViewLayout
//        insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsZero;
//}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // implement your cell selected logic here
    UIImageView * selectedImageView = self.iconsArray[indexPath.item];
    NSLog(@"selected image: %@", selectedImageView);
    if (indexPath.row == 0){
        NSLog(@"print calender");
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"chatSegue" sender:self];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"toDoSegue" sender:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating...");
    [self printCurrentCard];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate){
        NSLog(@"scrollViewDidEndDragging...");
        [self printCurrentCard];
    }
}

- (void)printCurrentCard{
    NSArray * visibleCards = self.collectionView.visibleCells;
    [visibleCards enumerateObjectsUsingBlock:^(WheelCollectionViewCell * visibleCell, NSUInteger idx, BOOL *stop) {
        NSLog(@"visible cell: %@", visibleCell.imageName);
    }];
}

- (void) initImages {
    self.iconsArray = [NSMutableArray array];
    self.imageNamesArray = [NSMutableArray array];
    
    UIImageView * image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calender2Icon.png"]];
    UIImageView * image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chatIconImage.png"]];
    UIImageView * image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"todoListIcon.png"]];
    UIImageView * image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calender2Icon.jpeg"]];
    UIImageView * image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chatIconImage.jpeg"]];
    UIImageView * image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"todoListIcon.jpeg"]];
    
    [self.iconsArray addObject:image1];
    self.imageNamesArray[0] = @"calender";
    [self.iconsArray addObject:image2];
    self.imageNamesArray[1] = @"chat";
    [self.iconsArray addObject:image3];
    self.imageNamesArray[2] = @"toDo";
    [self.iconsArray addObject:image4];
    self.imageNamesArray[3] = @"5";
    [self.iconsArray addObject:image5];
    self.imageNamesArray[4] = @"6";
    [self.iconsArray addObject:image6];
    self.imageNamesArray[5] = @"7";
}

@end
