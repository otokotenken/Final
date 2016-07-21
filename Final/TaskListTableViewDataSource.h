//
//  TaskListTableViewDataSource.h
//  
//
//  Created by DetroitLabs on 7/20/16.
//
//

#import <Foundation/Foundation.h>

@protocol TaskListTableViewDataSource <NSObject>

// Indicates the number of rows in the table
-(NSInteger)numberOfRows;

// Obtains the cell for the given row
-(UIView *)cellForRow:(NSInteger)row;

// Informs the datasource that a new item has been added at the top of the table
-(void)itemAdded;

@end
