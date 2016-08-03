//
//  EventsController.h
//  Final
//
//  Created by DetroitLabs on 8/1/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditEventViewControllerDelegate.h"

@interface EventsController : UIViewController <EditEventViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblEvents;

- (IBAction)showCalendars:(id)sender;

- (IBAction)createEvent:(id)sender;

@end

