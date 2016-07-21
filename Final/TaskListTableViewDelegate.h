//
//  TaskListTableViewDelegate.h
//  Final
//
//  Created by DetroitLabs on 7/20/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskListTableViewDelegate <NSObject>

// Indicates the number of rows in the table
-(NSInteger)numberOfRows;

// Obtains the cell for the given row
-(UIView *)cellForRow:(NSInteger)row;

@end
