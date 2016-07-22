//
//  TaskListTableView.h
//  Final
//
//  Created by DetroitLabs on 7/20/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListTableViewDataSource.h"
#import "TaskListTableViewCell.h"
#define SHC_ROW_HEIGHT 70.0f

@interface TaskListTableView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id<TaskListTableViewDataSource> dataSource;

@property (nonatomic, assign, readonly) UIScrollView* scrollView;

// dequeues a cell that can be reused
-(UIView*)dequeueReusableCell;

// registers a class for use as new cells
-(void)registerClassForCells:(Class)cellClass;

// an array of cells that are currently visible, sorted from top to bottom.
-(NSArray*)visibleCells;

// forces the table to dispose of all the cells and re-build the table.
-(void)reloadData;

@property (nonatomic, assign) id<UIScrollViewDelegate> delegate;

@end
