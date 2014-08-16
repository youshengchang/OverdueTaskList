//
//  ITIViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITIAddTaskViewController.h"
#import "ITIDetailTaskViewController.h"

@interface ITIViewController : UIViewController <ITIAddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, ITIDetailViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *taskTableView;

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;

@end
