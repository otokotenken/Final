//
//  ToDoListViewController.h
//  Final
//
//  Created by DetroitLabs on 7/18/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListTableViewDragAddNew.h"
#import "TaskListCellDelegate.h"
#import "TaskListTableViewDataSource.h"

@interface ToDoListViewController : UIViewController <TaskListCellDelegate, TaskListTableViewDataSource>

@property (nonatomic) IBOutlet TaskListTableView *tableView;

@end
