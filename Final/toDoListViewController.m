//
//  ToDoListViewController.m
//  Final
//
//  Created by DetroitLabs on 7/18/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "ToDoListViewController.h"
#import "TaskListItem.h"
#import "TaskListTableViewCell.h"
//#import "TaskListTableView.h"

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController {
    
    NSMutableArray *_toDoItems;
    // the offset applied to cells when entering “edit mode”
    float _editingOffset;
    TaskListTableViewDragAddNew* _dragAddNew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
//    _tableView.dataSource = self;
//    self.tableView.delegate = self;
//    
////    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////    self.tableView.backgroundColor = [UIColor blackColor];
//    [self.tableView registerClass:[TaskListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self makeTaskList];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClassForCells:[TaskListTableViewCell class]];
    _dragAddNew = [[TaskListTableViewDragAddNew alloc] initWithTableView:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)makeTaskList {
    _toDoItems = [[NSMutableArray alloc] init];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Feed the cat"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Buy eggs"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Pack bags for WWDC"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Rule the web"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Buy a new iPhone"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Find missing socks"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Write a new tutorial"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Master Objective-C"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Remember your wedding anniversary!"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Drink less beer"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Learn to draw"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Take the car to the garage"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Sell things on eBay"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Learn to juggle"]];
    [_toDoItems addObject:[TaskListItem toDoItemWithText:@"Give up"]];
    return self;
}

#pragma mark - TaskListTableViewDataSource methods
-(NSInteger)numberOfRows {
    return _toDoItems.count;
}

-(UITableViewCell *)cellForRow:(NSInteger)row {
    TaskListTableViewCell* cell = (TaskListTableViewCell*)[self.tableView dequeueReusableCell];
    TaskListItem *item = _toDoItems[row];
    cell.todoItem = item;
    cell.delegate = self;
    cell.backgroundColor = [self colorForIndex:row];
    return cell;
}
-(void)toDoItemDeleted:(id)todoItem {
    float delay = 0.0;
    
    // remove the model object
    [_toDoItems removeObject:todoItem];
    
    // find the visible cells
    NSArray* visibleCells = [self.tableView visibleCells];
    
    UIView* lastView = [visibleCells lastObject];
    bool startAnimating = false;
    
    // iterate over all of the cells
    for(TaskListTableViewCell* cell in visibleCells) {
        if (startAnimating) {
            [UIView animateWithDuration:0.5
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 if (cell == lastView) {
                                     [self.tableView reloadData];
                                 }
                             }];
            delay+=0.03;
        }
        
        // if you have reached the item that was deleted, start animating
        if (cell.todoItem == todoItem) {
            startAnimating = true;
            cell.hidden = YES;
        }
    }
}


-(void)cellDidBeginEditing:(TaskListTableViewCell *)editingCell {
    _editingOffset = _tableView.scrollView.contentOffset.y - editingCell.frame.origin.y;
    for(TaskListTableViewCell* cell in [_tableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, _editingOffset);
                             if (cell != editingCell) {
                                 cell.alpha = 0.3;
                             }
                         }];
    }
}

-(void)cellDidEndEditing:(TaskListTableViewCell *)editingCell {
    for(TaskListTableViewCell* cell in [_tableView visibleCells]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, -_editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 1.0;
                             }
                         }];
    }
}


-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:0.8];
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

-(void)itemAdded {
    // create the new item
    TaskListItem* toDoItem = [[TaskListItem alloc] init];
    [_toDoItems insertObject:toDoItem atIndex:0];
    // refresh the table
    [_tableView reloadData];
    // enter edit mode
    TaskListTableViewCell* editCell;
    for (TaskListTableViewCell* cell in _tableView.visibleCells) {
        if (cell.todoItem == toDoItem) {
            editCell = cell;
            break;
        }
    }
    [editCell.label becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
