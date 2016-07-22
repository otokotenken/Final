//
//  TaskListCellDelegate.h
//  
//
//  Created by DetroitLabs on 7/19/16.
//
//

#import <Foundation/Foundation.h>
#import "TaskListTableViewCell.h"
#import "TaskListItem.h"

@class TaskListTableViewCell;

@protocol TaskListCellDelegate <NSObject>

-(void) toDoItemDeleted:(TaskListItem*)todoItem;

// Indicates that the edit process has begun for the given cell
-(void)cellDidBeginEditing:(TaskListTableViewCell*)cell;

// Indicates that the edit process has committed for the given cell
-(void)cellDidEndEditing:(TaskListTableViewCell*)cell;

@end
