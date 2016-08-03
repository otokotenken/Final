//
//  CalendarsViewController.h
//  Final
//
//  Created by DetroitLabs on 8/1/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblCalendars;

- (IBAction)editCalendars:(id)sender;

@end
