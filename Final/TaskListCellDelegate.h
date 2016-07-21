//
//  TaskListCellDelegate.h
//  Final
//
//  Created by DetroitLabs on 7/19/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#ifndef TaskListCellDelegate_h
#define TaskListCellDelegate_h
#import "TaskListItem.h"

@protocol TaskListCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(TaskListItem *)todoItem;

@end

#endif /* TaskListCellDelegate_h */
