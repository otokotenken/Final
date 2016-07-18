//
//  WheelCollectionViewLayout.h
//  Final
//
//  Created by DetroitLabs on 7/14/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) UIView * superView;
@property (nonatomic, strong)NSMutableArray * modifiedLayoutAttributesArray;

@end
