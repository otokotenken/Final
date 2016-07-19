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

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController {
    
    NSMutableArray *_toDoItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[TaskListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self makeTaskList];
    _tableView.backgroundColor = [UIColor clearColor];
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

#pragma mark - UITableViewDataSource protocol methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_toDoItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    // re-use or create a cell
    TaskListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
//    [cell.textLabel setFont:[UIFont systemFontOfSize:26.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:19.0]];
    // find the to-do item for this index
    NSInteger index = [indexPath row];
    TaskListItem *item = _toDoItems[index];
    // set the text
    NSString *taskText = item.textTask;
    //grab the nsstring text for the cell
    cell.textLabel.text = taskText;
    return cell;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
