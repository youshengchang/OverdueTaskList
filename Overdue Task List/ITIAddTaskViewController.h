//
//  ITIAddTaskViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITITaskObject.h"

@protocol ITIAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(ITITaskObject *)task;


@end

@interface ITIAddTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
