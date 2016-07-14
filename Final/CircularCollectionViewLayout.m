//
//  CircularCollectionViewLayout.m
//  Final
//
//  Created by DetroitLabs on 7/13/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "CircularCollectionViewLayout.h"

@implementation CircularCollectionViewLayout


-(void)settingSizeWithRadius{
    CGSize itemSize = CGSizeMake(133, 173);
    var radius: CGFloat = 500 {
        didSet {
            invalidateLayout()
        }
    }


}

@end
