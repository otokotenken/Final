//
//  TaskListItem.h
//  Final
//
//  Created by DetroitLabs on 7/18/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListItem : NSObject

//what the task is called.
@property (nonatomic, copy) NSString *textTask;

// A Boolean value that determines the completed state of this item.
@property (nonatomic) BOOL completed;

// Returns an SHCToDoItem item initialized with the given text.
-(id)initWithText:(NSString*)textTask;

// makes creation easier
+(id)toDoItemWithText:(NSString*)textTask;

@end
