//
//  TaskListTableViewCell.h
//  Final
//
//  Created by DetroitLabs on 7/19/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListItem.h"
#import "TaskListCellDelegate.h"
#import "TaskListStrikethroughLabel.h"

@interface TaskListTableViewCell : UITableViewCell <UITextFieldDelegate>

// The item that this cell renders.
@property (nonatomic) TaskListItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<TaskListCellDelegate> delegate;

// the label used to render the to-do text
@property (nonatomic, strong, readonly) TaskListStrikethroughLabel* label;

@end
