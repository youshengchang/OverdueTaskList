//
//  ITIViewController.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITIViewController.h"

@interface ITIViewController ()

@end

@implementation ITIViewController

-(NSMutableArray *)taskObjects
{
    if(!_taskObjects){
        _taskObjects = [[NSMutableArray alloc]init];
        
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *taskAsPropertList = [[NSUserDefaults standardUserDefaults]objectForKey:OVERDUE_TASKS];
    for(NSDictionary *dictionary in taskAsPropertList){
        [self.taskObjects addObject:[self getTaskObjectFromDictionary:dictionary]];
         
    }
    
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
    if (self.taskTableView.editing) {
        self.taskTableView.editing = NO;
    }else{
        self.taskTableView.editing = YES;
    }
    
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

#pragma mark Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"toAddTaskViewControllerSegue"]){
        NSLog(@"segue's identifier: %@", segue.identifier);
        ITIAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    if([segue.identifier isEqualToString:@"toDetailTaskViewControllerSegue"]){
        NSLog(@"selecting go to Detail View");
        ITIDetailTaskViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        ITITaskObject *detailTask = self.taskObjects[indexPath.row];
        NSLog(@"detailtask: %@, %@, %@", detailTask.title, detailTask.description, detailTask.date);
        detailVC.task = detailTask;
        detailVC.indexpath = indexPath;
        detailVC.delegate = self;
        
    }
    
}

#pragma mark - helper methods
-(NSDictionary *)taskObjectAsAPropertyList:(ITITaskObject *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE:taskObject.title, TASK_DESCRIPTION:taskObject.description, TASK_DATE:taskObject.date, TASK_COMPLETION:@(taskObject.completion)};
    
    NSLog(@"dictionary inside of taskObjectAsPropertyList: %@", dictionary);
    
    return dictionary;
}

-(ITITaskObject *)getTaskObjectFromDictionary: (NSDictionary *)dictionary
{
    ITITaskObject *task = [[ITITaskObject alloc]initWithData:dictionary];
    
    return task;
    
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    //NSLog(@"date: %@ and toDate: %@", date, toDate);
    
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateTimeInterval = [toDate timeIntervalSince1970];
    //NSLog(@"dateTimeInterval: %f toDateTimeInterval: %f", dateTimeInterval, toDateTimeInterval);
    if(dateTimeInterval > toDateTimeInterval)
        return YES;
    else
        return NO;
    
    
}

-(void)updateCompletionOfTask:(ITITaskObject *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrayAsPropertyList = [[[NSUserDefaults standardUserDefaults]arrayForKey:OVERDUE_TASKS]mutableCopy];
    if(arrayAsPropertyList == nil){
        arrayAsPropertyList = [[NSMutableArray alloc]init];
        
    }
    
    NSDictionary *dictionary = [self taskObjectAsAPropertyList:task];
    
    [arrayAsPropertyList setObject:dictionary atIndexedSubscript:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:arrayAsPropertyList forKey:OVERDUE_TASKS];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)saveTasks
{
    NSMutableArray *arrayAsPropertyList = [[NSMutableArray alloc]init];
    
    for(ITITaskObject *task in self.taskObjects){
        NSDictionary *dictionary = [self taskObjectAsAPropertyList:task];
        [arrayAsPropertyList addObject:dictionary];
    }
    [[NSUserDefaults standardUserDefaults]setObject:arrayAsPropertyList forKey:OVERDUE_TASKS];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark UITableViewDelegate and UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [self.taskObjects count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    ITITaskObject *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    NSDate *date = task.date;
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd h:mm a"];
    NSString *dateString = [formater stringFromDate:date];
    cell.detailTextLabel.text = dateString;
    if(task.completion == YES){
        cell.backgroundColor = [UIColor greenColor];
    }else{
        if([self isDateGreaterThanDate:[NSDate date] and:task.date]){
            cell.backgroundColor = [UIColor redColor];
        }else{
            cell.backgroundColor = [UIColor yellowColor];
        }
    }

    return cell;
}
#pragma mark implements the UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ITITaskObject *task = self.taskObjects[indexPath.row];
    
    task.completion = !(task.completion);
    [self updateCompletionOfTask:task forIndexPath:indexPath];
    [self.taskObjects  setObject:task atIndexedSubscript:indexPath.row];
    [self.taskTableView reloadData];
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //ITITaskObject *task = self.taskObjects[indexPath.row];
    
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSMutableArray *arrayAsPropertyList = [[[NSUserDefaults standardUserDefaults]arrayForKey:OVERDUE_TASKS]mutableCopy];
        [arrayAsPropertyList removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:arrayAsPropertyList forKey:OVERDUE_TASKS];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        [self.taskTableView reloadData];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ITITaskObject *task = [self.taskObjects objectAtIndex:sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    NSLog(@"%@", task);
    [self.taskObjects insertObject:task atIndex:destinationIndexPath.row];
    NSLog(@"taskObjects: %@", self.taskObjects);
    [self saveTasks];
   
    
}
#pragma mark - ITIAddTaskViewControllerDelegate methods
-(void)didCancel
{
    NSLog(@"get Cancel Message");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didAddTask:(ITITaskObject *)task
{
    NSLog(@"task's title: %@ task's description: %@ task's date: %@ task's completion: %i", task.title, task.description, task.date, task.completion);
    NSMutableArray *arrayAsPropertyList = [[[NSUserDefaults standardUserDefaults]arrayForKey:OVERDUE_TASKS]mutableCopy];
    if(arrayAsPropertyList == nil){
        arrayAsPropertyList = [[NSMutableArray alloc]init];
        
    }
    //NSLog(@"arrayAsPropertyList: %@", arrayAsPropertyList);
    
    NSDictionary *dictionary = [self taskObjectAsAPropertyList:task];
    //NSLog(@"dictionary: %@", dictionary);
    
    [arrayAsPropertyList addObject:dictionary];
    
    //NSLog(@"arrayAsPropertyList: %@", arrayAsPropertyList);
    [[NSUserDefaults standardUserDefaults]setObject:arrayAsPropertyList forKey:OVERDUE_TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.taskObjects addObject:task];
    [self.taskTableView reloadData];
}

#pragma mark - implementing the ITIDetailViewControllerDelegate
-(void)didEdit:(ITITaskObject *)task atIndex:(NSIndexPath *)indexPath
{
    NSLog(@"task completion: %i",task.completion);
    [self.taskObjects setObject:task atIndexedSubscript:indexPath.row];
    [self saveTasks];
    [self.taskObjects setObject:task atIndexedSubscript:indexPath.row];
    [self.taskTableView reloadData];
    
}
@end
