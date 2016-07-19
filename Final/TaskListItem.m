//
//  TaskListItem.m
//  Final
//
//  Created by DetroitLabs on 7/18/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "TaskListItem.h"

@implementation TaskListItem {
// NSMutableArray* _toDoItems;
}

-(id)initWithText:(NSString*)textTask {
    if (self = [super init]) {
        self.textTask = textTask;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)textTask {
    return [[TaskListItem alloc] initWithText:textTask];
}

@end
