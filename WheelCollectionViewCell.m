//
//  WheelCollectionViewCell.m
//  
//
//  Created by DetroitLabs on 7/14/16.
//
//

#import "WheelCollectionViewCell.h"

@implementation WheelCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImageView:(UIImageView *)imageView {
    imageView = imageView;
    [self addSubview:imageView];
}

-(void)setBackgroundImage:(UIImageView *)backgroundImage{
    backgroundImage = backgroundImage;
    [self addSubview:backgroundImage];
}

@end
