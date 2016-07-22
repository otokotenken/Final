//
//  TaskListTableViewPinchToAdd.h
//  Final
//
//  Created by DetroitLabs on 7/21/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskListTableView.h"

// A behavior to pinch the list in order to insert a new item at any location.

@interface TaskListTableViewPinchToAdd : NSObject

// associates this behavior with the given table
-(id)initWithTableView:(TaskListTableView*)tableView;

@end
