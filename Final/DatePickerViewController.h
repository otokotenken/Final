//
//  DatePickerViewController.h
//  Final
//
//  Created by DetroitLabs on 8/1/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelegate

-(void)dateWasSelected:(NSDate *)selectedDate;

@end


@interface DatePickerViewController : UIViewController

@property (nonatomic, strong) id<DatePickerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *dtDatePicker;


- (IBAction)acceptDate:(id)sender;


@end
