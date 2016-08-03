//
//  EditEventViewController.h
//  Final
//
//  Created by DetroitLabs on 8/1/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
#import "EditEventViewControllerDelegate.h"

//@protocol EditEventViewControllerDelegate
//
//-(void)eventWasSuccessfullySaved;
//
//@end


@interface EditEventViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, DatePickerViewControllerDelegate>

@property (nonatomic, strong) id<EditEventViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tblEvent;

- (IBAction)saveEvent:(id)sender;

@end