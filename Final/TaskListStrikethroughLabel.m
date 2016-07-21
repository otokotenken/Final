//
//  TaskListStrikethroughLabel.m
//  Final
//
//  Created by DetroitLabs on 7/19/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "TaskListStrikethroughLabel.h"

@implementation TaskListStrikethroughLabel {
    
CALayer* _strikethroughLayer;
}

const float STRIKEOUT_THICKNESS = 2.0f;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self resizeStrikeThrough];
}
-(void)setText:(NSString *)text {
    [super setText:text];
    [self resizeStrikeThrough];
}

// resizes the strikethrough layer to match the current label text
-(void)resizeStrikeThrough {
//    CGSize textSize = [self.text sizeWithAttributes:self.font];
    CGSize textSize = [self.text sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"Noteworthy-Bold" size:19]}];
    _strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height/2,
                                           textSize.width, STRIKEOUT_THICKNESS);
}

#pragma mark - property setter
-(void)setStrikethrough:(bool)shouldBeStrikethrough {
    _shouldBeStrikethrough = shouldBeStrikethrough;
    _strikethroughLayer.hidden = !shouldBeStrikethrough;
}

@end
